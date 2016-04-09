class ReposController < ApplicationController
  before_action :authorize!, only: [:show, :create, :destroy]

  def index
    @repos = client.repos.list(user: client.user, auto_pagination: true).map { |repo| repo.name if repo.has_issues? }
  end

  def show
    @repo = Repo.find(params[:id])

    set_client_repo_name(@repo)

    @issues = client.issues.list user: client.user, repo: client.repo

    @labels ||= client.issues.labels.list
  end

  def create
    repo = current_user.repos.create(name: params[:name])

    if repo
      set_client_repo_name(repo)
      set_current_project(repo)
      create_labels
      flash[:success] = "Repository successfully added!"

      redirect_to repos_path
    else
      flash[:danger] = "Unable to add repository!"

      render 'repos'
    end
  end

  def destroy
    repo = Repo.find(params[:id])

    if repo.destroy
      destroy_labels
      unset_client_repo_name
      unset_current_project

      flash[:success] = "Repository successfully removed!"
    else
      flash[:danger] = "Repository was not removed!"
    end

    redirect_to repos_path
  end

  private

  def repo_params
    params.require(:repo).permit(:id, :name)
  end

  def client
    current_user.github if current_user
  end

  def set_client_repo_name(repo)
    client.repo = repo.name
  end

  def set_current_project(repo)
    current_user.current_repo = repo.name
    current_user.save
  end

  def unset_client_repo_name
    client.repo = ''
  end

  def unset_current_project
    current_user.current_repo = ''
  end

  def statuses
    {
      'Backlog'     => '1FFFFF',
      'Ready'       => 'F3FFFF',
      'In-progress' => 'FF5FFF',
      'Completed'   => 'FF7FFF'
    }
  end

  def times
    %w{ 5 300 600 1500 3000 }
  end

  def create_labels
    labels = client.issues.labels.list.map { |label| label.name }

    statuses.delay.each do |status, color|
      unless labels.include?(status)
        client.issues.labels.create name: status, color: color
      end
    end

    times.delay.each do |time|
      unless labels.include?(time)
        client.issues.labels.create name: time, color: '000000'
      end
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

    statuses.delay.each do |status|
      unless !labels.include?(status)
        client.issues.labels.delete client.user, client.repo, status
      end
    end

    times.delay.each do |time|
      unless !labels.include?(time)
        client.issues.labels.delete client.user, client.repo, time
      end
    end
  end
end
