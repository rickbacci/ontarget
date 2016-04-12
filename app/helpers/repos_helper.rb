module ReposHelper

  def current_user_added_repo(name)
    current_user.repos.find_by(name: name) ? true : false
  end

  def has_label?(labels, name)
    labels.any?{ |label| label.name == name}
  end

  def set_default(label)
    label.name == 'Backlog' ? true : false
  end

  def different?(issue, status)
    issue.labels.none? { |label| label.name == status }
  end

  def get_time(labels)
    labels.map { |label| return label.name if times.include?(label.name) }
    '5'
  end

  def convert_time(seconds)
    timer_values.each { |time, desc| return desc if time == seconds }
  end

end
