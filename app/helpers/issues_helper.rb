module IssuesHelper

  def label_data?(label_name)
    return true if statuses.include?(label_name) || times.include?(label_name)
    false
  end


  def time_match?(new_time, original_time)
    return true if new_time == original_time
    false
  end

  def set_default_time(time)
    return true if time == '5'
    false
  end
end

