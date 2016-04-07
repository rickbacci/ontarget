require 'rails_helper'

feature "User" do
  include OmniAuthUser

  before do
    stub_omniauth
  end

  scenario "can logout and destroy the session" do
    VCR.use_cassette("destroy_session") do
      visit root_path

      expect(page).to_not have_link('Logout')

      click_on "Login with Github"

      expect(page).to have_link('Logout')

      click_on "Logout"

      expect(page).to have_link('Login with Github')
    end
  end
end

