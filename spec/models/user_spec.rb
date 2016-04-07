require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.create!(nickname: 'ricky', provider: 'github',
                             token: 'asdf', uid: 175, current_repo: 'no_sleep') }


  it 'creates a valid user' do
    expect(User.first).to be_valid
  end

  it 'can have many repos' do
    user = User.first
    expect(user.repos).to eq([])
  end

  it 'has a github client' do
    user = User.first
    expect(user.github.user).to eq('ricky')
    expect(user.github.oauth_token).to eq('asdf')
    expect(user.github.repo).to eq('no_sleep')
    expect(user.github.oauth_token).to eq('asdf')
  end
end
