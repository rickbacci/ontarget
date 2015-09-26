class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])

    client.repo = @project.name

    @backlog     = client.issues.list(user: 'rickbacci', repo: @project.name, labels: 'backlog')
    @ready       = client.issues.list(user: 'rickbacci', repo: @project.name, labels: 'ready')
    @in_progress = client.issues.list(user: 'rickbacci', repo: @project.name, labels: 'in-progress')
    @completed   = client.issues.list(user: 'rickbacci', repo: @project.name, labels: 'completed')
  end

  def new
    @repos = client.repos.list(per_page: 100).map do |repo|
      repo.name
    end
  end

  def create
    project = current_user.projects.create(name: params[:name])

    client.repo = project.name
    current_user.current_project = project.name

    client.issues.labels.create name: 'backlog', color: '1FFFFF'
    client.issues.labels.create name: 'ready', color: 'F3FFFF'
    client.issues.labels.create name: 'in-progress', color: 'FF5FFF'
    client.issues.labels.create name: 'completed', color: 'FFF7FF'

    if project
      flash[:success] = "Repository successfully added to your project list!"
      redirect_to new_project_path
    else
      flash[:danger] = "Unable to add repository to your project list!"
      render 'projects'
    end
  end

  def destroy
    Project.find(params[:id]).destroy

    flash[:success] = "Repository removed from your project list!"
    redirect_to projects_path
  end


  private

  def project_params
    params.require(:project).permit(:id, :name)
  end

  def client
    IssuesController::GithubColumnUpdater
      .github_for(client_id:     ENV['github_id'],
                  client_secret: ENV['github_secret'],
                  oauth_token:   current_user.token,
                  user:          current_user.nickname,
                  repo:          current_user.current_project)
  end
end
