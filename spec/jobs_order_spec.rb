require 'rspec'
require './lib/jobs_order'

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

      expect(result.index 'b').to be > result.index('c')
    end
  end
end
