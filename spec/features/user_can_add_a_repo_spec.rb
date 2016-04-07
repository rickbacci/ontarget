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

      expect(page).to have_content('Your Repositories')
      expect(page).to_not have_css('.test_repo-added')
      expect(page).to have_content('test_repo')

      find('.test_repo.add-repo-button').click()

      expect(page).to have_content('Repository successfully added!')

      click_on 'test_repo'

      expect(page).to have_content('Backlog')
      expect(page).to have_content('Ready')
      expect(page).to have_content('In-progress')
      expect(page).to have_content('Completed')

      delete_test_repo('test_repo')
    end
  end
end

