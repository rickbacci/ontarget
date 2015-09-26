require 'rails_helper'

class TestGithubColumnUpdater
  attr_accessor :updates

  def initialize
    @updates = []
  end

  def call(attributes)
    updates << attributes
  end
end

RSpec.describe 'whatever' do
  it 'updates github when I move the squares between the columns' do
    updater = TestGithubColumnUpdater.new
    IssuesController.update_column = updater
    # capybara stuff to go to the page and move the square


    expect(updater.updates).to eq [{
      owner:         'some owner',
      repo:          'test_repo',
      number:        '235',
      old_column:    'backlog',
      new_column:    'ready',
      oauth_token:   'my token',
      user:          'my user nickname',
      client_id:     'my test client id',
      client_secret: 'my test client secret',
    }]
  end
end
