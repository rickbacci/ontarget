class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])

    current_user.current_project = @project.name
    current_user.save

    @issues = current_user.client.issues.list(repo: @project.name)
    @labels = current_user.client.issues.labels.list
  end

  def new
    @repos = current_user.client.repos.list().map do |repo|
      repo.name
    end
  end

  def create
    project = current_user.projects.create(name: params[:name])

    update_project_name(project)

    create_labels

    if project
      flash[:success] = "Repository successfully added to your project list!"
      redirect_to new_project_path
    else
      flash[:danger] = "Unable to add repository to your project list!"
      render 'projects'
    end
  end

  def destroy

    project_name = Project.find_by(name: params[:id])

    if project_name
      project_name.destroy
      destroy_labels
    end

    flash[:success] = "Repository removed from your project list!"
    redirect_to projects_path
  end


  def create_labels
    labels = current_user.client.issues.labels.list.map { |label| label.name }

    unless labels.include?('backlog')
      current_user.client.issues.labels.create name: 'backlog', color: '1FFFFF'
    end

    unless labels.include?('ready')
      current_user.client.issues.labels.create name: 'ready', color: 'F3FFFF'
    end

    unless labels.include?('in-progress')
      current_user.client.issues.labels.create name: 'in-progress', color: 'FF5FFF'
    end

    unless labels.include?('completed')
      current_user.client.issues.labels.create name: 'completed', color: 'FFF7FF'
    end
  end

  def destroy_labels
    labels = current_user.client.issues.labels.list.map { |label| label.name }

    if labels.include?('backlog')
      current_user.client.issues.labels.delete client.user, client.repo, 'backlog'
    end

    if labels.include?('ready')
      current_user.client.issues.labels.delete client.user, client.repo, 'ready'
    end

    if labels.include?('in-progress')
      current_user.client.issues.labels.delete client.user, client.repo, 'in-progress'
    end

    if labels.include?('completed')
      current_user.client.issues.labels.delete client.user, client.repo, 'completed'
    end
  end

  def update_project_name(project)
    current_user.client.repo = project.name
    current_user.current_project = project.name
    current_user.save
  end

  private

  def project_params
    params.require(:project).permit(:id, :name)
  end
end
