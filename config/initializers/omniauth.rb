Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
  ENV['github_id'],
  ENV['github_secret'],
  scope: "user,repo, delete_repo"
end
