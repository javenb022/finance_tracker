require "rails_helper"

# future tests: wrong values in fields

RSpec.feature "User Signup" do
  describe "Happy path tests" do
    let(:user) { create(:user) }

    scenario "User signs up with valid credentials" do
      visit new_user_registration_path

      fill_in "user_email", with: "test@email.com"
      fill_in "user_password", with: "password123"
      fill_in "user_password_confirmation", with: "password123"
      fill_in "user_first_name", with: "Sarah"
      fill_in "user_last_name", with: "Doe"
      fill_in "user_phone_number", with: "987-654-3210"
      fill_in "user_address", with: "456 Elm St"
      fill_in "user_city", with: "Othertown"
      fill_in "user_state", with: "CA"
      fill_in "user_zip_code", with: "54321"
      fill_in "user_date_of_birth", with: "2000-01-01"
      click_button "Sign up"

      expect(page).to have_content("Welcome! You have signed up successfully.")
      expect(page).to have_current_path(root_path)
    end
  end

  describe "Sad path tests" do
    let(:user) { create(:user) }

    scenario "User signs up with invalid email" do
      visit new_user_registration_path

      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password
      fill_in "user_first_name", with: user.first_name
      fill_in "user_last_name", with: user.last_name
      fill_in "user_phone_number", with: user.phone_number
      fill_in "user_address", with: user.address
      fill_in "user_city", with: user.city
      fill_in "user_state", with: user.state
      fill_in "user_zip_code", with: user.zip_code
      fill_in "user_date_of_birth", with: user.date_of_birth
      click_button "Sign up"

      expect(page).to have_content("Email has already been taken")
      expect(page).to have_current_path(user_registration_path)
    end

    scenario "User signs up with mismatched passwords" do
      visit new_user_registration_path

      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: "nottherightpassword"
      fill_in "user_first_name", with: user.first_name
      fill_in "user_last_name", with: user.last_name
      fill_in "user_phone_number", with: user.phone_number
      fill_in "user_address", with: user.address
      fill_in "user_city", with: user.city
      fill_in "user_state", with: user.state
      fill_in "user_zip_code", with: user.zip_code
      fill_in "user_date_of_birth", with: user.date_of_birth
      click_button "Sign up"

      expect(page).to have_content("Password confirmation doesn't match Password")
      expect(page).to have_current_path(user_registration_path)
    end

    scenario "User signs up missing required fields" do
      visit new_user_registration_path

      fill_in "user_email", with: "newuser@email.com"
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password
      fill_in "user_first_name", with: user.first_name
      # fill_in "user_last_name", with: user.last_name
      fill_in "user_phone_number", with: user.phone_number
      fill_in "user_address", with: user.address
      fill_in "user_city", with: user.city
      fill_in "user_state", with: user.state
      # fill_in "user_zip_code", with: user.zip_code
      fill_in "user_date_of_birth", with: user.date_of_birth
      click_button "Sign up"

      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Zip code can't be blank")
      expect(page).to have_current_path(user_registration_path)

      expect(page).to have_no_content("Email has already been taken")
      expect(page).to have_no_content("Password confirmation doesn't match Password")
      expect(page).to have_no_content("Password can't be blank")
    end
  end
end
