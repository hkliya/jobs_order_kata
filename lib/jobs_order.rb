class JobsOrder
  def initialize(jobs_description)
    @jobs = parse jobs_description
  end

  def order
    result = []
    @jobs.each { |job_name, dependency|
      result << dependencies_of(dependency)
      result << job_name
    }
    result.flatten
  end

  def self.process(jobs_description)
    JobsOrder.new(jobs_description).order()
  end

  private
  def parse(jobs_list)
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

  def dependencies_of(job)
    return [] if job.nil?
    result = dependencies_of dependency_of(job)
    result << job
  end

  def dependency_of(job)
    @jobs[job]
  end
end
