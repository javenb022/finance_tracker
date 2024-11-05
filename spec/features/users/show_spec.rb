require "rails_helper"
require "date"

RSpec.feature "User show page" do
  let(:user) { create(:user) }

  context "when user is logged in" do
    before do
      login_as(user)
      visit profile_path
    end

    scenario "user can see their profile" do
      disabled_first_name = find('input#first-name-input', visible: false).value
      expect(disabled_first_name).to eq(user.first_name)
      disabled_last_name = find('input#last-name-input', visible: false).value
      expect(disabled_last_name).to eq(user.last_name)
      disabled_email = find('input#email-input', visible: false).value
      expect(disabled_email).to eq(user.email)
      disabled_phone = find('input#phone-input', visible: false).value
      expect(disabled_phone).to eq(user.phone_number)
      disabled_address = find('input#address-input', visible: false).value
      expect(disabled_address).to eq(user.address)
      disabled_city = find('input#city-input', visible: false).value
      expect(disabled_city).to eq(user.city)
      disabled_state = find('input#state-input', visible: false).value
      expect(disabled_state).to eq(user.state)
      disabled_zip_code = find('input#zip-code-input', visible: false).value
      expect(disabled_zip_code).to eq(user.zip_code)
      disabled_date_of_birth = find('input#date-of-birth-input', visible: false).value
      expected_date = user.date_of_birth.strftime("%Y-%m-%d")
      expect(disabled_date_of_birth).to eq(expected_date)
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