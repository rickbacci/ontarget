require 'rails_helper'

feature "User" do
  include OmniAuthUser

  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    stub_omniauth
  end

  scenario "can authenticate with Github" do
    VCR.use_cassette("authenticate") do
      visit root_path

      expect(page).to_not have_link('Logout')

      click_on "Login"

      expect(page).to have_link('Logout')
    end
  end

  it 'with Github is successful' do
    VCR.use_cassette('login') do
      visit root_path

      expect(page.status_code).to eq(200)


      click_link "Login with Github"

      expect(page).to have_css("#logout")
      expect(page).to have_link("Logout")
    end
  end
end

