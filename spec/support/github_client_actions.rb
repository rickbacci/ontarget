module GithubRepo

  def create_client
    @github ||= Github.new do |c|
      c.client_id     = ENV['github_test_id']
      c.client_secret = ENV['github_test_secret']
      c.oauth_token   = ENV['github_test_token']
      c.user          = ENV['github_test_user']
    end
  end

  def create_test_repo(name)
    @github.repos.create name: name
  end

  def delete_test_repo(name)
    @github.repos.delete @github.user, name
  end
end

