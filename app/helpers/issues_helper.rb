module IssuesHelper

  def label_data?(label_name)
    statuses.include?(label_name) || times.include?(label_name) ? true : false
  end

  def set_default_time(time)
    time == '5' ? true : false
  end

  def set_original_time(time, original_time)
    time == original_time ? true : false
  end
end

