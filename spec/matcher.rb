require 'rspec/expectations'

RSpec::Matchers.define :have_order do |first_job, second_job|
  match do |sequence|
    sequence.index(first_job) < sequence.index(second_job)
  end

  failure_message_for_should do |actual|
    "expected that #{actual} to have job '#{first_job}' before '#{second_job}'"
  end
end
