require "rails_helper"

RSpec.describe "User Dashboard" do
  before do
    Timecop.freeze(Time.zone.local(2024, 8, 1))
  end
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let!(:categories) { create_list(:category, 3, user:) }
  let!(:account) { create_list(:account, 3, user:) }
  let!(:old_transactions) { create_list(:transaction, 15, user:, account: account.sample, category: categories.sample, transaction_date: 1.month.ago) }
  let!(:recent_transactions) { create_list(:transaction, 5, user:, account: account.sample, category: categories.sample, transaction_date: Time.zone.today) }

  context "when user is logged in" do
    scenario "user can see the dashboard" do
      login_as(user)
      visit dashboard_path

      expect(page).to have_content("#{user.first_name}'s Dashboard")
      expect(page).to have_current_path(dashboard_path)
    end

    scenario "user can see their accounts and balances" do
      account = create(:account, user:)

      login_as(user)
      visit dashboard_path

      expect(page).to have_content("Accounts")
      expect(page).to have_content(account.name)
      expect(page).to have_content("$#{account.balance}")
    end

    scenario "user can see their 5 most recent transactions" do
      login_as(user)
      visit dashboard_path

      within(".recent-transactions") do
        recent_transactions.each do |transaction|
          expect(page).to have_content(transaction.description)
        end
      end
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
