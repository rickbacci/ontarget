module OmniAuthUser

  def stub_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      {
        provider: 'github',
        uid:      ENV['github_test_uid'],
        info: {
          nickname:    "me",
          name:        "JOE SMOE",
          email:       "e@mail.com"
        },
        credentials: {
          token:  ENV['github_test_token'],
          secret: ENV['github_test_secret']
        }
      })
  end

  def mock_auth
    {
      provider: 'github',
      uid:      ENV['github_test_uid'],
      info: {
        nickname:    "me",
        name:        "JOE SMOE",
        email:       "e@mail.com"
      },
      credentials: {
        token:  ENV['github_test_token'],
        secret: ENV['github_test_secret']
      }
    }
  end
end
