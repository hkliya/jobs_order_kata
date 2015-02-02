class JobsOrder
  def self.process(jobs_list)
    return [] if jobs_list.empty?
    result = []
    jobs_list.split(/\n/).each { |job_definition| 
      splitted = job_definition.strip().split('=>')
      job_name = splitted[0].strip()
      dependency = splitted[1]
      result << dependency.strip() unless dependency.nil?
      result << job_name
    }
    result
  end
end
