module OmniAuthUser

  def stub_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = nil

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      {
        provider:   ENV['test_provider'],
        uid:        ENV['test_uid'],
          info: {
          nickname: ENV['test_nickname'],
          email:    ENV['test_email'],
        },
        credentials: {
          token:    ENV['github_test_token'],
          secret:   ENV['github_test_secret']
        }
      })
  end

  def mock_auth
    {
      provider:   ENV['test_provider'],
      uid:        ENV['test_uid'],
        info: {
        nickname: ENV['test_nickname'],
        email:    ENV['test_email'],
      },
      credentials: {
        token:    ENV['github_test_token'],
        secret:   ENV['github_test_secret']
      }
    }
  end
end
