module ProjectsHelper

  def statuses
    ['backlog', 'ready', 'in-progress', 'completed']
  end

  def added_to_projects(project_name)
    current_user.projects.pluck(:name).include?(project_name)
  end

  def has_label?(labels, name)
    labels.any?{ |label| label.name == name}
  end

  def different_repo(issue, current_user)
    issue.repository.name != current_user.current_project
  end
  def different_column(issue, status)
    issue.labels.none? { |label| label.name == status }
  end

  def different?(issue, status, current_user)
    different_repo(issue, current_user) || different_column(issue, status)
  end

  def get_time(labels)
    return 25 if labels.include?('25')
    return 50 if labels.include?('50')
    5000
  end

  def set_time(time, value)
    return true if time == value
    false
  end
end
