class IssuesController < ApplicationController
  def index
    @issues = client.issues.list user: 'rickbacci', repo: 'test_repo'
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
    # current_user.github.issues.edit params[:owner], params[:repo], '28',
    current_user.github.issues.edit params[:owner], params[:repo], params[:number],
      title: params[:title],
      body: params[:body],
      assignee: params[:owner],
      labels: [
      "bug"
      ]

    flash[:success] = "Issue Updated!"
    redirect_to issues_path
  end

  def add_label
    current_user.github.issues.labels.add params[:owner], params[:repo], params[:number],
     'In Progress'
    flash[:success] = "label Updated!"
    redirect_to issues_path
  end


  private

  def client
    current_user.github if current_user
  end
end

