require 'rails_helper'

feature "User" do
  include OmniAuthUser
  let!(:project) { Project.create!(name: 'test_repo') }

  before do
    OmniAuth.config.mock_auth[:github] = nil
    stub_omniauth
  end


  scenario "can update an issues labels" do
    VCR.use_cassette("user_update_issue_labels") do
      visit root_path

      click_on "Login"

      project.user = User.first
      project.save

      click_on "Add Repository"
      find('.test_repo4').click
      click_on "View Projects"
      click_on "test_repo4"

      expect(page).to have_content('Backlog')
      expect(page).to have_content('Ready')
      expect(page).to have_content('In Progress')
      expect(page).to have_content('Completed')

      click_on "New Issue"

      fill_in "Title", with: 'New test issue'
      fill_in "User story...", with: "As a test user..."

      click_on "Create Issue"

      expect(page).to have_content('New test issue')
      expect(page).to have_content('As a test user...')

      fill_in "title", with: 'updated test issue'
      fill_in "body", with: "As a test user updated"

      # click_on "Update"

      expect(page).to have_content('updated test issue')
    end
  end
end

