require 'rails_helper'

feature "User" do
  include OmniAuthUser
  include GithubRepo

  before do
    stub_omniauth
    create_client
  end

  scenario "can add a repository" do
    VCR.use_cassette("user_add_repo") do
      create_test_repo('test_repo')

      visit root_path

      click_on "Login with Github"

      expect(page).to_not have_css('.test_repo-added')

      fill_in 'Search for a Repo', with: 't'

      expect(page).to have_content('test_repo')

      find('.test_repo-add-btn').click()

      expect(page).to have_content('Repository successfully added!')
      expect(page).to have_content('Backlog')
      expect(page).to have_content('Ready')
      expect(page).to have_content('Current')
      expect(page).to have_content('Completed')

      expect(page).to have_content('TEST_REPO')

      delete_test_repo('test_repo')
    end
  end
end

