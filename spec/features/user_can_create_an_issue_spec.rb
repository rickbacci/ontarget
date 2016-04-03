require 'rails_helper'

feature "User" do
  include OmniAuthUser
  include GithubRepo

  before do
    stub_omniauth
    create_client
  end

  scenario "can create an issue with a default time" do
    VCR.use_cassette("user_create_issue") do
      create_test_repo('test_repo')

      visit root_path
      click_on "Login with Github"

      click_on "Add Repository"
      find('.test_repo').click
      click_on "View Projects"
      click_on "test_repo"

      click_on "New Issue"

      fill_in "Title", with: 'New test issue'
      fill_in "User story...", with: "As a test user..."

      click_on "Create Issue"

      expect(page).to have_content('New test issue')
      expect(page).to have_content('As a test user...')
      expect(page).to have_content('5 seconds')

      delete_test_repo('test_repo')
    end
  end

  scenario "can create an issue with a 25 minute timer" do
    VCR.use_cassette("user_create_issue_with_25_minute_timer") do
      create_test_repo('test_repo')

      visit root_path
      click_on "Login with Github"

      click_on "Add Repository"
      find('.test_repo').click
      click_on "View Projects"
      click_on "test_repo"

      click_on "New Issue"

      fill_in "Title", with: 'New test issue'
      fill_in "User story...", with: "As a test user..."
      find('#1500').click()

      click_on "Create Issue"

      expect(page).to have_content('New test issue')
      expect(page).to have_content('As a test user...')
      expect(page).to have_content('25 minutes')

      delete_test_repo('test_repo')
    end
  end
end

