require 'rails_helper'

feature "User" do
  include OmniAuthUser
  include GithubRepo

  before do
    stub_omniauth
    create_client
  end


  scenario "can remove a project" do
    VCR.use_cassette("user_remove_project") do
      create_test_repo('test_repo')

      visit root_path
      click_on "Login"

      click_on "Add Repository"
      find('.test_repo').click

      click_on "View Projects"

      expect(page).to have_content('Your Projects')
      expect(page).to have_content('test_repo')

      find('.delete-test_repo-button').click

      expect(page).to have_content('Your Projects')
      expect(page).to have_content('Repository removed from your project list!')
      expect(page).to_not have_content('test_repo')

      delete_test_repo('test_repo')
    end
  end
end

