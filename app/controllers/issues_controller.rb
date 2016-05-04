class IssuesController < ApplicationController
  include GithubCardStatusUpdater
  include GithubIssueCreater
  include GithubIssueUpdater

  def new
    @labels     = client.issues.labels.list
    @milestones = client.issues.milestones.list
  end

  def self.create
    @create || GithubIssueCreater
  end

  def self.create=(create)
    @create = create
  end

  def create
    repo_name =  params[:repo_name]
    client.repo = repo_name

    labels = params.has_key?(:creation) ? params[:creation][:labels] : []

    labels << params[:timer_time] << 'Backlog'

    IssuesController.create.call(client:    client,
                                 title:     params[:title],
                                 body:      params[:body],
                                 milestone: params[:milestone],
                                 labels:    labels)

    flash[:success] = "Issue Created!"
    redirect_to repo_path(repo_name)
  end


  def self.update
    @update || GithubIssueUpdater
  end

  def self.update=(update)
    @update = update
  end

  def update
    IssuesController.update.call(
      client: client,
      number: params[:number],
      title:  params[:title],
      body:   params[:body],
      labels: params[:labels])
    head :ok
  end

  def self.update_card_status
    @update_card_status || GithubCardStatusUpdater
  end

  def self.update_card_status=(update_card_status)
    @update_card_status = update_card_status
  end

  def update_card_status

    IssuesController.update_card_status.call(
      client:     client,
      owner:      params[:owner],
      repo:       params[:repo],
      number:     params[:number],
      old_column: params[:oldcolumn],
      new_column: params[:newcolumn])

    head :ok
  end

  private

  def client
    current_user.github
  end
end

