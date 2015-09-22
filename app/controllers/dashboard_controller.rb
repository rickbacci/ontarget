class DashboardController < ApplicationController
  def show
  end

  def index
    @issues = client.issues.list user: 'rickbacci', repo: 'test_repo'
  end

  def in_progress
     # current_user.github.issues.labels.create name: 'toInProgress', color: 'FFFFFF'
    current_user.github.issues.labels.add('rickbacci', 'test_repo', params[:id],
      ['toInProgress', 'bug'])
    redirect_to repos_rickbacci_test_repo_labels_path

  end

  private

  def client
    current_user.github
  end
end
