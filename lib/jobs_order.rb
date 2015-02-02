class JobsOrder
  class << self
    def process(jobs_list)
      return [] if jobs_list.empty?
      jobs = parse_jobs jobs_list
      order jobs
    end

    private
    def order(jobs)
      result = []
      jobs.each { |job_name, dependency|
        result << dependencies(jobs, dependency)
        result << job_name
      }
      result.flatten
    end

    def parse_jobs(jobs_list)
      jobs = {}
      jobs_list.split(/\n/).each { |job_definition| 
        splitted = job_definition.strip().split('=>')
        job_name = splitted[0].strip()
        dependency = splitted[1]
        dependency.strip! unless dependency.nil?
        jobs.store job_name, dependency
      }
      jobs
    end

    def dependencies(jobs, dependency)
      return [] if dependency.nil?
      result = dependencies jobs, jobs[dependency]
      result << dependency
    end
  end
end
