class IssuesController < ApplicationController
  include GithubColumnUpdater
  include GithubIssueCreater
  include GithubIssueUpdater
  include GithubIssueLabelUpdater

  def new
    @project = Project.find(params[:id])
  end

  def self.update_issue_labels
    @update_issue_labels || GithubIssueLabelUpdater
  end

  def self.update_issue_labels=(update_issue_labels)
    @update_issue_labels = update_issue_labels
  end

  def update_issue_labels
    project = Project.find_by(name: current_user.github.repo)

    IssuesController.update_issue_labels
                    .call(client: current_user.github,
                          number: params[:number],
                          labels: params[:updates][:labels])

    flash[:success] = "Labels Updated!"
    redirect_to project_path(project.id)
  end


  def self.create
    @create || GithubIssueCreater
  end

  def self.create=(create)
    @create = create
  end

  def create
    @project = Project.find(params[:id])

    IssuesController.create
                    .call(client: current_user.github,
                          title:  params[:title],
                          body:   params[:body],
                          labels: ["backlog", params[:timer_time]])

    flash[:success] = "Issue Created!"
    redirect_to project_path(params[:id])
  end


  def self.update
    @update || GithubIssueUpdater
  end

  def self.update=(update)
    @update = update
  end

  def update
    @project = Project.find(params[:project_id])

    IssuesController.update.call(client: current_user.github,
                                 number: params[:number],
                                 title:  params[:title],
                                 body:   params[:body],
                                 labels: params[:labels].split)

    flash[:success] = "Issue Updated!"
    redirect_to project_path(params[:project_id])
  end


  def self.update_column
    @update_column || GithubColumnUpdater
  end

  def self.update_column=(update_column)
    @update_column = update_column
  end

  def update_column
    IssuesController.update_column.call(client:    current_user.github,
                                        number:     params[:number],
                                        old_column: params[:oldcolumn],
                                        new_column: params[:newcolumn])
    head :ok
  end
end

