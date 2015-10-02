require 'rails_helper'

feature "User" do
  include OmniAuthUser
  let!(:project) { Project.create!(name: 'test_repo') }

  before do
    OmniAuth.config.mock_auth[:github] = nil
    stub_omniauth
  end


  scenario "can remove a project" do
    VCR.use_cassette("user_remove_project") do
      visit root_path

      click_on "Login"

      project.user = User.first
      project.save

      click_on "View Projects"

      expect(page).to have_content('test_repo')

      click_on "Add Repository"
      find('.asset-pipeline-playground').click

      expect(page).to have_content('asset-pipeline-playground')

      click_on "View Projects"

      expect(page).to have_content('Your Projects')
      expect(page).to have_content('asset-pipeline-playground')

      find('.delete-asset-pipeline-playground-button').click

      expect(page).to have_content('Your Projects')
      expect(page).to have_content('Repository removed from your project list!')
    end
  end
end

