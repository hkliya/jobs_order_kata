class JobsOrder
  def initialize(jobs_description)
    @jobs = parse jobs_description
    raise "Jobs can't depend on themselves" if exist_self_referencing?
    raise "Jobs can't have circular dependencies" if exist_circular_dependency?
  end

  def order
    result = []
    @jobs.each_key { |job|
      result << dependencies_of(job)
    }
    result.flatten.uniq
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

  def exist_self_referencing?
    @jobs.each do |job, dependency|
       return true if job.eql? dependency
    end
    false
  end

  def exist_circular_dependency?
    @jobs.each do |job, dependency|
      dependencies = []
      cursor = job
      until cursor.nil? do
        return true if dependencies.include? cursor
        dependencies << cursor
        cursor = @jobs[cursor]
      end
    end
    false
  end
end
