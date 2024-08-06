require 'rails_helper'

RSpec.feature 'User updates account information' do
  let(:user) { create(:user) }

  background do
    login_as(user, scope: :user)
    visit edit_user_registration_path
  end

  describe 'Happy path tests' do
    scenario 'page has all the necessary fields' do
      expect(page).to have_field('user_email', with: user.email)
      expect(page).to have_field('user_password')
      expect(page).to have_field('user_password_confirmation')
      expect(page).to have_field('user_current_password')
      expect(page).to have_field('user_first_name', with: user.first_name)
      expect(page).to have_field('user_last_name', with: user.last_name)
      expect(page).to have_field('user_phone_number', with: user.phone_number)
      expect(page).to have_field('user_address', with: user.address)
      expect(page).to have_field('user_city', with: user.city)
      expect(page).to have_field('user_state', with: user.state)
      expect(page).to have_field('user_zip_code', with: user.zip_code)
      expect(page).to have_field('user_date_of_birth', with: user.date_of_birth)
    end

    scenario 'user updates their first name' do
      fill_in 'user_first_name', with: 'John'
      fill_in 'user_current_password', with: user.password
      click_button 'Update'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Your account has been updated successfully.')
      expect(user.reload.first_name).to eq('John')
    end

    scenario 'user updates their last name' do
      fill_in 'user_last_name', with: 'Doe'
      fill_in 'user_current_password', with: user.password
      click_button 'Update'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Your account has been updated successfully.')
      expect(user.reload.last_name).to eq('Doe')
    end

    scenario 'user updates their email' do
      fill_in 'user_email', with: 'new_email@example.com'
      fill_in 'user_current_password', with: user.password
      click_button 'Update'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Your account has been updated successfully.')
      expect(user.reload.email).to eq('new_email@example.com')
    end

    scenario 'user updates their password' do
      fill_in 'user_password', with: 'new_password'
      fill_in 'user_password_confirmation', with: 'new_password'
      fill_in 'user_current_password', with: user.password

      click_button 'Update'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Your account has been updated successfully.')
      expect(user.reload.valid_password?('new_password')).to be true
    end

    scenario 'user updates their phone number' do
      fill_in 'user_phone_number', with: '987-654-3210'
      fill_in 'user_current_password', with: user.password
      click_button 'Update'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Your account has been updated successfully.')
      expect(user.reload.phone_number).to eq('987-654-3210')
    end

    scenario 'user updates their address' do
      fill_in 'user_address', with: '456 Elm St'
      fill_in 'user_current_password', with: user.password
      click_button 'Update'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Your account has been updated successfully.')
      expect(user.reload.address).to eq('456 Elm St')
    end

    scenario 'user updates their city' do
      fill_in 'user_city', with: 'Othertown'
      fill_in 'user_current_password', with: user.password
      click_button 'Update'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Your account has been updated successfully.')
      expect(user.reload.city).to eq('Othertown')
    end

    scenario 'user updates their state' do
      fill_in 'user_state', with: 'CA'
      fill_in 'user_current_password', with: user.password
      click_button 'Update'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Your account has been updated successfully.')
      expect(user.reload.state).to eq('CA')
    end

    scenario 'user updates their zip code' do
      fill_in 'user_zip_code', with: '54321'
      fill_in 'user_current_password', with: user.password
      click_button 'Update'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Your account has been updated successfully.')
      expect(user.reload.zip_code).to eq('54321')
    end

    scenario 'user updates their date of birth' do
      fill_in 'user_date_of_birth', with: '2000-01-01'
      fill_in 'user_current_password', with: user.password
      click_button 'Update'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Your account has been updated successfully.')
      expect(user.reload.date_of_birth.to_s).to eq('2000-01-01')
    end

    scenario 'user updates multiple fields' do
      fill_in 'user_first_name', with: 'John'
      fill_in 'user_last_name', with: 'Doe'
      fill_in 'user_email', with: 'johndoe@email.com'
      fill_in 'user_current_password', with: user.password
      click_button 'Update'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Your account has been updated successfully.')
      expect(user.reload.first_name).to eq('John')
      expect(user.reload.last_name).to eq('Doe')
      expect(user.reload.email).to eq('johndoe@email.com')
    end
  end
end
