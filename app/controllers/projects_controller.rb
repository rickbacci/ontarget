class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])

    current_user.current_project = @project.name
    current_user.save

    @issues = client.issues.list(repo: @project.name)
    @labels = client.issues.labels.list
  end

  def new
    @repos = client.repos.list(per_page: 100).map do |repo|
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
    project_name = Project.find_by(name: params[:id]).destroy

    destroy_labels(project_name)

    flash[:success] = "Repository removed from your project list!"
    redirect_to projects_path
  end


  def create_labels
    client.issues.labels.create name: 'backlog', color: '1FFFFF'
    client.issues.labels.create name: 'ready', color: 'F3FFFF'
    client.issues.labels.create name: 'in-progress', color: 'FF5FFF'
    client.issues.labels.create name: 'completed', color: 'FFF7FF'
  end

  def destroy_labels(project_name)
    client.issues.labels.delete client.user, client.repo, 'backlog'
    client.issues.labels.delete client.user, client.repo, 'ready'
    client.issues.labels.delete client.user, client.repo, 'in-progress'
    client.issues.labels.delete client.user, client.repo, 'completed'
  end

  def update_project_name(project)
    client.repo = project.name
    current_user.current_project = project.name
    current_user.save
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
