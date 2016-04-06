class ReposController < ApplicationController
  before_action :authorize!, only: [:show, :create, :destroy]

  def index
    @repos = current_user.repos
  end

  def show

    @repo = Repo.find(params[:id])

    set_repo_name(@repo)

    @issues ||= client.issues.list user: client.user, repo: client.repo
    # @repo = client.repos.get user: client.user, name: client.repo
    @labels ||= client.issues.labels.list
    @repos = client.repos.list(user: client.user, auto_pagination: true).map { |repo| repo if repo.has_issues? }
  end

  def new
    @repos = client.repos.list(user: client.user, auto_pagination: true).map { |repo| repo if repo.has_issues? }
  end

  def create
    @repo = current_user.repos.create(name: params[:name])

    update_repo_name(@repo)

    create_labels

    if @repo
      flash[:success] = "Repository successfully added!"
      redirect_to new_repo_path
    else
      flash[:danger] = "Unable to add repository!"
      render 'repos'
    end
  end

  def destroy
    repo_name = Repo.find_by(name: params[:id])

    destroy_existing_repo(repo_name)

    flash[:success] = "Repository successfully removed!"
    redirect_to repos_path
  end

  private

  def repo_params
    params.require(:repo).permit(:id, :name)
  end

  def client
    current_user.github if current_user
  end

  def update_repo_name(repo)
    client.repo = repo.name
    current_user.current_repo = repo.name
    current_user.save
  end

  def set_repo_name(repo)
    current_user.current_repo = repo.name
    client.repo = repo.name
    current_user.save
  end

  def destroy_existing_repo(repo_name)
    if repo_name
      repo_name.destroy
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

    unless repo_issues.empty?
      repo_issues.each do |issue|
        next if client.issues.nil?
        next if issue.labels.nil?
        issue      = client.issues.get client.user, client.repo, issue.number
        is_backlog = issue.labels.any? { |l| l.name == 'Backlog' }

        if(!is_backlog)
          client.issues.labels.add client.user, client.repo, issue.number, 'Backlog'
        end
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
