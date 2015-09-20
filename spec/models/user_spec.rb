require 'rails_helper'

RSpec.describe User, type: :model do

  def mock_auth
    {
      "provider" => "github",
      "uid" => ENV['github_test_uid'],
      "info" =>
        {
          "nickname" => "me",
          "name" => "JOE SMOE"
        },
      "credentials" =>
      {
        "token" => ENV['github_test_token'],
        "secret" => ENV['github_test_secret']
      }
    }
  end

  before do
    @user = User.find_or_create_by(mock_auth)
  end

  xit 'creates a valid user from an auth hash' do
    expect(@user).to be_valid
  end
end
