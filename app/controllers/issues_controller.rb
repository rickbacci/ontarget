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
      "bug",
      "In Progress"
      ]

    flash[:success] = "Issue Updated!"
    redirect_to issues_path
  end


  private

  def client
    current_user.github
  end
end


    # github = Github.new user: 'rickbacci', repo: 'test_repo'
    # github = Github.new user: 'rickbacci', repo: 'test_repo'
    # github.issues.edit(number: '107634353',
