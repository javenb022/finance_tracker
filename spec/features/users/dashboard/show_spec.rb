require "rails_helper"

RSpec.describe "User Dashboard", type: :feature do
  let(:user) { create(:user) }

  context "when user is logged in" do
    scenario "user can see the dashboard" do
      login_as(user)
      visit dashboard_path

      expect(page).to have_content("#{user.first_name}'s Dashboard")
      expect(page).to have_current_path(dashboard_path)
    end

    scenario "user can see their accounts and balances" do
      account = create(:account, user: user)

      login_as(user)
      visit dashboard_path

      expect(page).to have_content("Accounts")
      expect(page).to have_content(account.name)
      expect(page).to have_content("$#{account.balance}")
    end
  end

  context "when user is not logged in" do
    scenario "user cannot see the dashboard" do
      visit dashboard_path

      expect(page).to have_content("You need to sign in or sign up before continuing.")
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end