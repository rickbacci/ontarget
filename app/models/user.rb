class User < ActiveRecord::Base
  has_many :projects

  def self.find_or_create_from_auth(data)
    user = User.find_or_create_by(provider: data['provider'], uid: data['uid'])

    user.email     = data['info']['email']
    user.nickname  = data['info']['nickname']
    user.image_url = data['info']['image']
    user.token     = data['credentials']['token']
    user.save
    user
  end
  def client
    IssuesController::GithubColumnUpdater
      .github_for(client_id:     ENV['github_id'],
                  client_secret: ENV['github_secret'],
                  oauth_token:   token,
                  user:          nickname,
                  repo:          current_project)
  end
end
