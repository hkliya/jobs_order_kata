class JobsOrder
  def self.process(jobs_list)
    return [] if jobs_list.empty?
    [jobs_list.chars[0]]
  end
end
