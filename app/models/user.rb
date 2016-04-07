class User < ActiveRecord::Base
  has_many :repos

  def self.find_or_create_from_auth(data)
    user = User.find_or_create_by(provider: data['provider'], uid: data['uid'])

    user.email     = data['info']['email']
    user.nickname  = data['info']['nickname']
    user.image_url = data['info']['image']
    user.token     = data['credentials']['token']
    user.save
    user
  end

  def github
    @github ||= Github.new do |c|
      c.client_id     = ENV['github_id']
      c.client_secret = ENV['github_secret']
      c.oauth_token   = token
      c.user          = nickname
      c.repo          = current_repo
    end
  end
end
