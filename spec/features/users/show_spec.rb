require "rails_helper"

RSpec.feature "User show page" do
  let(:user) { create(:user) }

  context "when user is logged in" do
    before do
      login_as(user)
      visit profile_path
    end

    scenario "user can see their profile" do
      expect(page).to have_content("#{user.first_name}'s Profile")
      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name)
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.phone_number)
      expect(page).to have_content(user.address)
      expect(page).to have_content(user.city)
      expect(page).to have_content(user.state)
      expect(page).to have_content(user.zip_code)
      expect(page).to have_content(user.date_of_birth)
      expect(page).to have_link("Edit Profile")
    end

    scenario "user can click on the edit profile link" do
      click_link "Edit Profile"
      expect(current_path).to eq edit_user_registration_path
    end
  end

  context "when user is not logged in" do
    before do
      visit profile_path
    end

    scenario "user is redirected to the root path" do
      expect(page).to have_content("You must be logged in to visit that page.")
      expect(current_path).to eq root_path
    end
  end
end