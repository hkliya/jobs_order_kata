require 'rspec'
require './lib/jobs_order'
require './spec/matcher'

describe 'JobsOrder' do
  describe '#process' do
    context 'given an empty string' do
      it 'returns empty sequence' do
        expect(JobsOrder.process '').to eql []
      end
    end

    it 'processes a single job' do
      expect(JobsOrder.process 'a => ').to eql ['a']
    end

    it 'processes multiple jobs' do
      jobs = "a =>
              b =>
              c =>"
      expect(JobsOrder.process jobs).to include(*['a', 'b', 'c'])
    end

    it 'processes multiple jobs with single dependency' do
      jobs = "a =>
              b => c
              c =>"

      result = JobsOrder.process jobs
      expect(result).to include(*['a', 'b', 'c'])
      expect(result).to have_order('c', 'b')
    end

    it 'processes multiple jobs with multiple dependencies' do
      jobs = "a =>
              b => c
              c => f
              d => a
              e => b
              f =>"

      result = JobsOrder.process jobs

      expect(result).to include(*['a', 'b', 'c', 'd', 'e', 'f'])
      expect(result).to have_order('f', 'c')
      expect(result).to have_order('c', 'b')
      expect(result).to have_order('b', 'e')
      expect(result).to have_order('a', 'd')
    end

    it 'raises error when exist self referencing dependency' do
      jobs = "a =>
              b =>
              c =>c"

      expect{
        JobsOrder.process jobs
      }.to raise_error("Jobs can't depend on themselves")
    end
  end
end
