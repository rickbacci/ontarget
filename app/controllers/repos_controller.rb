class ReposController < ApplicationController
  before_action :authorize!, only: [:show, :create, :destroy]

  def index
    @repos = client.repos.list(user: client.user,
                               auto_pagination: true,
                               sort: :updated)

  end

  def show
    repo_name = params[:repo_name]
    set_client_and_current_repo_names(repo_name)

    @issues = client.issues.list user: client.user, repo: client.repo
    @labels = client.issues.labels.list
  end

  def create
    repo_name  = params[:repo_name]
    has_issues = params[:has_issues]

    if current_user.repos.create(name: repo_name, has_issues: has_issues)

      set_client_and_current_repo_names(repo_name)
      create_labels

      flash[:success] = "Repository successfully added!"
      redirect_to repo_path(repo_name)
    else
      flash[:danger] = "Unable to add repository!"
      render 'repos'
    end
  end

  def destroy
    repo_name = params[:repo_name]
    repo      = Repo.find_by(name: repo_name)

    if repo.destroy
      destroy_labels
      unset_client_and_current_repo_names

      flash[:success] = "Repository successfully removed!"
    else
      flash[:danger] = "Repository was not removed!"
    end

    redirect_to repos_path
  end

  def activate_repo_issues
    repo_name = params[:repo_name]
    client.repos.edit user: client.user, repo: repo_name,
      name: repo_name, has_issues: true
    redirect_to repos_path
  end


  private

  def repo_params
    params.require(:repo).permit(:id, :name)
  end

  def client
    current_user.github if current_user
  end

  def set_client_and_current_repo_names(repo_name)
    current_user.update(current_repo: repo_name)
    client.repo = current_repo
  end

  def unset_client_and_current_repo_names
    current_user.update(current_repo: nil)
    client.repo = nil
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
