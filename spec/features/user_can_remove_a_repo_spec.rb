require 'rails_helper'

feature "User" do
  include OmniAuthUser
  include GithubRepo

  before do
    stub_omniauth
    create_client
  end


  scenario "can remove a repo" do
    VCR.use_cassette("user_remove_repo") do
      create_test_repo('test_repo')

      visit root_path
      click_on "Login with Github"

      fill_in 'Search for a Repo', with: 't'
      find('.test_repo-add-btn').click()

      expect(page).to have_content('Repository successfully added!')

      fill_in 'Search for a Repo', with: 't'
      find('.test_repo-delete-btn').click

      expect(page).to have_content('Repository successfully removed!')
      expect(page).to_not have_css('.test_repo-added')

      delete_test_repo('test_repo')
    end
  end
end

