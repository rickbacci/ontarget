module IssuesHelper

  def statuses
    ['Backlog', 'Ready', 'In-progress', 'Completed']
  end

  def times
    %w{ 5 300 600 1500 3000 }
  end

  def label_data?(label_name)
    return true if statuses.include?(label_name) || times.include?(label_name)
    false
  end

  def timer_times
    { '5'    => '5 seconds',
      '300'  => '5 minutes',
      '600'  => '10 minutes',
      '1500' => '25 minutes',
      '3000' => '50 minutes'
    }
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

