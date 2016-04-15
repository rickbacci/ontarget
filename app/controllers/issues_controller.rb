class IssuesController < ApplicationController
  include GithubCardStatusUpdater
  include GithubIssueCreater
  include GithubIssueUpdater
  include GithubIssueLabelUpdater

  def new
    @labels     = client.issues.labels.list
    @milestones = client.issues.milestones.list
  end

  def update_issue_times
    issue_number  = params[:issue_number]
    original_time = params[:time]
    new_time      = params[:timer_time]

    client.issues.labels.add client.user, client.repo, issue_number, new_time
    client.issues.labels.remove client.user, client.repo, issue_number, label_name: original_time

    flash[:success] = "Timer Updated!"

    redirect_to repo_path(current_repo)
  end

  def self.update_issue_labels
    @update_issue_labels || GithubIssueLabelUpdater
  end

  def self.update_issue_labels=(update_issue_labels)
    @update_issue_labels = update_issue_labels
  end

  def update_issue_labels
    IssuesController.update_issue_labels.call(client: client,
                                              number: params[:number],
                                              labels: params[:updates][:labels])

    flash[:success] = "Labels Updated!"
    redirect_to repo_path(current_repo)
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

    IssuesController.create.call(client: client,
                                 title:  params[:title],
                                 body:   params[:body],
                                 labels: labels)

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
    IssuesController.update.call(client: client,
                                 number: params[:number],
                                 title:  params[:title],
                                 body:   params[:body],
                                 labels: params[:labels].split)

    flash[:success] = "Issue Updated!"
    redirect_to repo_path(current_repo)
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

