require 'rails_helper'

feature "User" do
  include OmniAuthUser
  let!(:project) { Project.create!(name: 'test_repo') }

  before do
    OmniAuth.config.mock_auth[:github] = nil
    stub_omniauth
  end


  scenario "can create an issue with a default time" do
    VCR.use_cassette("user_create_issue") do
      visit root_path

      click_on "Login"

      project.user = User.first
      project.save

      click_on "Add Repository"
      find('.asset-pipeline-playground').click
      click_on "View Projects"
      click_on "asset-pipeline-playground"

      expect(page).to have_content('Backlog')
      expect(page).to have_content('Ready')
      expect(page).to have_content('In Progress')
      expect(page).to have_content('Completed')

      click_on "New Issue"

      expect(page).to have_content('New Issue')

      fill_in "Title", with: 'New test issue'
      fill_in "User story...", with: "As a test user..."

      click_on "Create Issue"

      expect(page).to have_content('New test issue')
      expect(page).to have_content('As a test user...')
    end
  end

  scenario "can create an issue with a 25 minute timer" do
    VCR.use_cassette("user_create_issue_with_25_minute_timer") do
      visit root_path

      click_on "Login"

      project.user = User.first
      project.save

      click_on "Add Repository"
      find('.asset-pipeline-playground').click
      click_on "View Projects"
      click_on "asset-pipeline-playground"

      expect(page).to have_content('Backlog')
      expect(page).to have_content('Ready')
      expect(page).to have_content('In Progress')
      expect(page).to have_content('Completed')

      click_on "New Issue"

      expect(page).to have_content('New Issue')

      fill_in "Title", with: 'New test issue'
      fill_in "User story...", with: "As a test user..."
      choose('25 minutes')

      click_on "Create Issue"

      expect(page).to have_content('New test issue')
      expect(page).to have_content('As a test user...')
      expect(page).to have_content('25 minutes')
    end
  end
end

