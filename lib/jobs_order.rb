class JobsOrder
  def self.process(jobs_list)
    return [] if jobs_list.empty?
    jobs_list.split(/\n/).map { |job_definition| 
      job_name = job_definition.strip().chars[0]
      job_name
    }
  end
end
