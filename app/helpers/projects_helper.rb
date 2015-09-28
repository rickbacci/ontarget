module ProjectsHelper

  def added_to_projects(project_name)
    current_user.projects.pluck(:name).include?(project_name)
  end

  def has_label?(labels, name)
    labels.any?{ |label| label.name == name}
  end
end
