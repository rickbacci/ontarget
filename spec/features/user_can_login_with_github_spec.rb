require 'rails_helper'

feature "User" do
  include OmniAuthUser

  before do
    OmniAuth.config.mock_auth[:github] = nil
    stub_omniauth
  end

  scenario "can authenticate with Github" do
    VCR.use_cassette("authenticate_user") do
      visit root_path
      expect(page).to_not have_link('Logout')

      click_on "Login with Github"

      expect(page).to have_link('Logout')
    end
  end
end

