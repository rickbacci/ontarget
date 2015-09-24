class IssuesController < ApplicationController
  def index
    @backlog = client.issues.list(user: 'rickbacci', repo: 'test_repo', labels: 'backlog')
    @ready = client.issues.list(user: 'rickbacci', repo: 'test_repo', labels: 'ready')
    @in_progress = client.issues.list(user: 'rickbacci', repo: 'test_repo', labels: 'in-progress')
    @completed = client.issues.list(user: 'rickbacci', repo: 'test_repo', labels: 'completed')
  end

  def new
  end

  def create
    current_user.github.issues.create(
      title: params[:title],
      body: params[:body],
      assignee: "rickbacci",
      labels: [
        "backlog"
      ])

    flash[:success] = "Issue Created!"
    redirect_to issues_path
  end

  def edit
  end

  def update
    current_user.github.issues.edit params[:owner], params[:repo], params[:number],
      title: params[:title],
      body: params[:body],
      assignee: params[:owner],
      labels: params[:labels].split

    flash[:success] = "Issue Updated!"
    redirect_to issues_path
  end

  def update_label
    current_user.github.issues.labels.update params[:owner], params[:repo], params[:name], name: 'bug', color: "FFFFFF"
  end

  def update_column
    current_user.github.issues.labels.remove params[:owner], params[:repo], params[:number],
      label_name: params[:oldcolumn]

    current_user.github.issues.labels.add params[:owner], params[:repo], params[:number],
      params[:newcolumn]

    head :ok
  end

  private

  def client
    current_user.github if current_user
  end
end

