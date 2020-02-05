Rails.application.config.middleware.use OmniAuth::Builder do
  # TODO: do I need this?
  # provider :developer unless Rails.env.production?

  provider :github,
  ENV['github_id'],
  ENV['github_secret'],
  scope: "read:user,public_repo"
end
