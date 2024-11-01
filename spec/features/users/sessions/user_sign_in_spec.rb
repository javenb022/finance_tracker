require 'rails_helper'

RSpec.feature 'User Sign In' do
  let(:user) { create(:user) }

  describe 'Happy path tests' do
    scenario 'User can sign in with valid credentials' do
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign In'

      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_current_path(dashboard_path)
    end
  end

  describe "Sad path tests" do
    scenario 'User cannot sign in with invalid credentials' do
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'wrong_password'
      click_button 'Sign In'

      expect(page).to have_content('Invalid Email or password.')
      expect(page).to have_current_path(new_user_session_path)
    end

    scenario 'User cannot sign in with an invalid email' do
      visit new_user_session_path

      fill_in 'Email', with: 'terrible_email'
      fill_in 'Password', with: user.password
      click_button 'Sign In'

      expect(page).to have_content('Invalid Email or password.')
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
