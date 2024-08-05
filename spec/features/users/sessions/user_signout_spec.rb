require "rails_helper"

RSpec.feature "User Sign Out", type: :feature do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  describe "Happy path tests" do
    scenario "User signs out successfully" do
      visit root_path
      click_button "Sign out"

      expect(page).to have_content("Signed out successfully.")
      expect(page).to have_current_path(root_path)
      expect(page).to have_link("Sign in")
      expect(page).to have_link("Sign up")
    end

    scenario "User cannot access restricted pages after signing out" do
      visit root_path
      click_button "Sign out"

      visit edit_user_registration_path
      expect(page).to have_content("You need to sign in or sign up before continuing.")
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end