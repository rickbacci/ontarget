require 'rails_helper'

feature "User" do
  include OmniAuthUser

  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    stub_omniauth
  end


  scenario "can select a project" do
    VCR.use_cassette("user_select_project") do
      visit root_path

      click_on "Login"

      user = User.first
      project = user.projects.create!(name: 'test_repo')

      click_on "View Projects"

      expect(page).to have_content('test_repo')

      find('.project-name-button').click

      expect(page).to have_content('Backlog')
      expect(page).to have_content('Ready')
      expect(page).to have_content('In Progress')
      expect(page).to have_content('Completed')
    end
  end
end

