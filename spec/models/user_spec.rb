require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.create!(nickname: 'ricky', provider: 'github',
                             token: 'asdf', uid: 175, current_project: 'no_sleep') }


  it 'creates a valid user' do
    expect(User.first).to be_valid
  end

  it 'can have many projects' do
    user = User.first
    expect(user.projects).to eq([])
  end

  it 'has a github client' do
    user = User.first
    expect(user.client.user).to eq('ricky')
    expect(user.client.oauth_token).to eq('asdf')
    expect(user.client.repo).to eq('no_sleep')
    expect(user.client.oauth_token).to eq('asdf')
  end
end
