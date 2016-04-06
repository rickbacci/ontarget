require 'rails_helper'

feature "User" do
  include OmniAuthUser
  include GithubRepo

  before do
    stub_omniauth
    create_client
  end

  scenario "does not see data labels in cards" do
    VCR.use_cassette("user_does_not_see_data_labels") do
      create_test_repo('test_repo')

      visit root_path
      click_on "Login with Github"

      click_on "Add Repository"
      find('.test_repo').click
      click_on "View Repositories"
      click_on "test_repo"

      click_on "New Issue"

      fill_in "Title", with: 'New test issue'
      fill_in "User story...", with: "As a test user..."

      click_on "Create Issue"

      expect(page).to_not have_css('.card-labels-backlog')
      expect(page).to_not have_css('.card-labels-5')

      delete_test_repo('test_repo')
    end
  end
end

