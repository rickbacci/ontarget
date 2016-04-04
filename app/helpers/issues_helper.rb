module IssuesHelper

  def label_data?(label_name)
    return true if statuses.include?(label_name) || times.include?(label_name)
    false
  end

  def set_time_value(time, original_time='')
    return true if time == '5' && original_time == ''
    return true if time == original_time
    false
  end

end

