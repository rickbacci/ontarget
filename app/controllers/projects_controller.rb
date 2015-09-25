class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])

    # current_user.github.repo = @project.name

    @backlog     = client.issues.list(user: 'rickbacci', repo: @project.name, labels: 'backlog')
    @ready       = client.issues.list(user: 'rickbacci', repo: @project.name, labels: 'ready')
    @in_progress = client.issues.list(user: 'rickbacci', repo: @project.name, labels: 'in-progress')
    @completed   = client.issues.list(user: 'rickbacci', repo: @project.name, labels: 'completed')
  end

  def new
    @repos = current_user.github.repos.list(per_page: 100).map do |repo|
      repo.name
    end

  end

  def create
    project = current_user.projects.create(name: params[:name])

    current_user.github.repo = project.name

    current_user.github.issues.labels.create name: 'backlog', color: '1FFFFF'
    current_user.github.issues.labels.create name: 'ready', color: 'F3FFFF'
    current_user.github.issues.labels.create name: 'in-progress', color: 'FF5FFF'
    current_user.github.issues.labels.create name: 'completed', color: 'FFF7FF'

    if project
      flash[:success] = "Repository successfully added to your project list!"
      redirect_to new_project_path
    else
      flash[:danger] = "Unable to add repository to your project list!"
      render 'projects'
    end
  end

  def destroy

    project = Project.find(params[:id])

    project.destroy

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
end
