module ProjectsHelper

  def added_to_projects(project_name)
    current_user.projects.pluck(:name).include?(project_name)
  end
end
