require 'rails_helper'

feature "User" do
  include OmniAuthUser
  let!(:project) { Project.create!(name: 'test_repo') }

  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    stub_omniauth
  end


  scenario "can select a project" do
    VCR.use_cassette("user_select_project") do
      visit root_path

      click_on "Login"

      project.user = User.first
      project.save

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

