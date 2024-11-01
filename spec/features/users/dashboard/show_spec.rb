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

    # scenario "user can see their monthly transactions" do
    #   category1 = create(:category, user:)
    #   category2 = create(:category, user:)
    #   category3 = create(:category, user:)

    #   account1 = user.accounts.create!(name: "Test Checking", balance: 1000.00, currency: "USD", account_type: 0)
    #   account2 = user.accounts.create!(name: "Savings", balance: 1000.00, currency: "USD", account_type: 1)
    #   account3 = user.accounts.create!(name: "Checking", balance: 5000.00, currency: "USD", account_type: 0)

    #   user.transactions.create!(amount: 100.00, transaction_type: 1, category: category1, transaction_date: Time.zone.today - 1.month, account: account1, description: "Transaction 1")
    #   user.transactions.create!(amount: 250.00, transaction_type: 0, category: category2, transaction_date: Time.zone.today - 1.day, account: account3, description: "Transaction 2")
    #   user.transactions.create!(amount: 70.00, transaction_type: 1, category: category3, transaction_date: Time.zone.today, account: account1, description: "Transaction 3")
    #   user.transactions.create!(amount: 400.00, transaction_type: 2, category: category1, transaction_date: Time.zone.today - 2.months, account: account3, description: "Transaction 4")
    #   user.transactions.create!(amount: 150.00, transaction_type: 1, category: category2, transaction_date: Time.zone.today - 4.days, account: account1, description: "Transaction 5")
    #   user.transactions.create!(amount: 30.00, transaction_type: 0, category: category3, transaction_date: Time.zone.today, account: account3, description: "Transaction 6")
    #   user.transactions.create!(amount: 200.00, transaction_type: 1, category: category1, transaction_date: Time.zone.today - 3.days, account: account2, description: "Transaction 7")

    #   login_as(user)
    #   visit dashboard_path

    #   # expect(page).to have_content("Current Months Transactions")
    #   expect(page).to have_content("Transaction 1")
    #   expect(page).to have_content("Transaction 2")
    #   expect(page).to have_content("Transaction 3")
    #   expect(page).to have_content("Transaction 4")
    #   expect(page).to have_content("Transaction 5")
    #   expect(page).to have_content("Transaction 6")
    #   expect(page).to have_content("Transaction 7")

    #   expect(page).to have_content("Test Checking")
    #   expect(page).to have_content("Savings")
    # end

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
