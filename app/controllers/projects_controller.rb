class ProjectsController < ApplicationController
  before_action :authorize!, only: [:show, :create, :destroy]

  def index
    @projects = current_user.projects
  end

  def show
    @project = Project.find(params[:id])

    set_project_name(@project)

    @issues ||= client.issues.list user: client.user, repo: client.repo

    @labels ||= client.issues.labels.list
  end

  def new
    @repos ||= client.repos.list(user: client.user, auto_pagination: true).map { |repo| repo if repo.has_issues? }
  end

  def create
    @project = current_user.projects.create(name: params[:name])

    update_project_name(@project)

    create_labels

    if @project
      flash[:success] = "Repository successfully added to your project list!"
      redirect_to new_project_path
    else
      flash[:danger] = "Unable to add repository to your project list!"
      render 'projects'
    end
  end

  def destroy
    project_name = Project.find_by(name: params[:id])

    destroy_existing_project(project_name)

    flash[:success] = "Repository removed from your project list!"
    redirect_to projects_path
  end


  private

  def project_params
    params.require(:project).permit(:id, :name)
  end

  def client
    current_user.github if current_user
  end

  def update_project_name(project)
    client.repo = project.name
    current_user.current_project = project.name
    current_user.save
  end

  def set_project_name(project)
    current_user.current_project = project.name
    client.repo = project.name
    current_user.save
  end

  def destroy_existing_project(project_name)
    if project_name
      project_name.destroy
      destroy_labels
    end
  end

  def create_labels
    labels = client.issues.labels.list.map { |label| label.name }

    unless labels.include?('Backlog')
      client.issues.labels.create name: 'Backlog', color: '1FFFFF'
    end

    unless labels.include?('Ready')
      client.issues.labels.create name: 'Ready', color: 'F3FFFF'
    end

    unless labels.include?('In-progress')
      client.issues.labels.create name: 'In-progress', color: 'FF5FFF'
    end

    unless labels.include?('Completed')
      client.issues.labels.create name: 'Completed', color: 'FFF7FF'
    end

    repo_issues = client.issues.list user: client.user, repo: client.repo, state: 'open'

    repo_issues.each do |issue|
      issue      = client.issues.get client.user, client.repo, issue.number
      is_backlog = issue.labels.any? { |l| l.name == 'Backlog' }

      if(!is_backlog)
        client.issues.labels.add client.user, client.repo, issue.number, 'Backlog'
      end
    end
  end

  def destroy_labels
    labels = client.issues.labels.list.map { |label| label.name }

    if labels.include?('Backlog')
      client.issues.labels.delete client.user, client.repo, 'Backlog'
    end

    if labels.include?('Ready')
      client.issues.labels.delete client.user, client.repo, 'Ready'
    end

    if labels.include?('In-progress')
      client.issues.labels.delete client.user, client.repo, 'In-progress'
    end

    if labels.include?('Completed')
      client.issues.labels.delete client.user, client.repo, 'Completed'
    end

    if labels.include?('5')
      client.issues.labels.delete client.user, client.repo, '5'
    end

    if labels.include?('300')
      client.issues.labels.delete client.user, client.repo, '300'
    end

    if labels.include?('600')
      client.issues.labels.delete client.user, client.repo, '600'
    end

    if labels.include?('1500')
      client.issues.labels.delete client.user, client.repo, '1500'
    end

    if labels.include?('3000')
      client.issues.labels.delete client.user, client.repo, '3000'
    end
  end
end
