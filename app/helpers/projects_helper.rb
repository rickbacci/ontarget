module ProjectsHelper

  def added_to_projects(project_name)
    current_user.projects.pluck(:name).include?(project_name)
  end

  def has_label?(labels, name)
    labels.any?{ |label| label.name == name}
  end

  def get_labels(labels)
    # labels.map do |label|
      # next if label.name == 'backlog' || 'ready' || 'in-progress' || 'completed'
      # %li{ class: "btn btn-xs", style: "background-color:\##{label.color};margin-top:10px" }
      # = label.name
    # end
  end
end
