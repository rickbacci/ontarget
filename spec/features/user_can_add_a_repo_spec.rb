require 'rails_helper'

feature "User" do
  include OmniAuthUser
  let!(:project) { Project.create!(name: 'test_repo') }

  before do
    OmniAuth.config.mock_auth[:github] = nil
    stub_omniauth
  end


  scenario "can add a repository" do
    VCR.use_cassette("user_add_repo") do
      visit root_path

      click_on "Login"

      project.user = User.first
      project.save

      expect(page).to have_content('test_repo')
      expect(page).to_not have_content('asset-pipeline-playground')


      click_on "New Project"

      expect(page).to have_content('Your Repositories')
      expect(page).to have_content('asset-pipeline-playground')

      find('.asset-pipeline-playground').click

      expect(page).to have_content('asset-pipeline-playground')

      click_on "View Projects"

      expect(page).to have_content('Your Projects')
      expect(page).to have_content('asset-pipeline-playground')

      click_on "asset-pipeline-playground"

      expect(page).to have_content('Backlog')
      expect(page).to have_content('Ready')
      expect(page).to have_content('In Progress')
      expect(page).to have_content('Completed')
    end
  end
end

