require 'rails_helper'

RSpec.feature "User login", type: :feature do
  include OmniAuthUser

  before do
    OmniAuth.config.mock_auth[:github] = nil
    stub_omniauth
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

