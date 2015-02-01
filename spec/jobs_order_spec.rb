require 'rspec'
require './lib/jobs_order'

describe 'JobsOrder' do
  describe '#process' do
    context 'given an empty string' do
      it 'returns empty sequence' do
        expect(JobsOrder.process '').to eql []
      end
    end
  end
end
