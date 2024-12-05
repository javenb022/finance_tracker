require "rails_helper"

RSpec.describe "Adding an Account" do
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
    scenario "user can add a checking account" do
      login_as(user)
      visit dashboard_path

      expect(page).to have_css("#add-account", visible: true)
      click_button "add-account"
      fill_in "name", with: "Checking_72"
      fill_in "balance", with: 1000
      choose "account_type_checking"
      click_on "submit-account"

      expect(page).to have_current_path(dashboard_path)
      expect(page).to have_content("Checking_72")
      expect(page).to have_content("$1000.00")
      expect(page).to have_content("Account added successfully")
      expect(page).to_not have_content("Savings_72")
      expect(page).to_not have_content("$2000.00")
    end

    scenario "user can add a savings account" do
      login_as(user)
      visit dashboard_path

      expect(page).to have_css("#add-account", visible: true)
      click_button "add-account"
      fill_in "name", with: "Savings_202"
      fill_in "balance", with: 2000
      choose "account_type_savings"
      click_on "submit-account"

      expect(page).to have_current_path(dashboard_path)
      expect(page).to have_content("Savings_202")
      expect(page).to have_content("$2000.00")
      expect(page).to have_content("Account added successfully")
      expect(page).to_not have_content("Checking_72")
      expect(page).to_not have_content("$1000.00")
    end

    scenario "user can add a credit card account" do
      login_as(user)
      visit dashboard_path

      expect(page).to have_css("#add-account", visible: true)
      click_button "add-account"
      fill_in "name", with: "Credit_101"
      fill_in "balance", with: 300
      choose "account_type_credit"
      click_on "submit-account"

      expect(page).to have_current_path(dashboard_path)
      expect(page).to have_content("Credit_101")
      expect(page).to have_content("$300.00")
      expect(page).to have_content("Account added successfully")
      expect(page).to_not have_content("Checking_72")
      expect(page).to_not have_content("$1000.00")
    end
  end

  context "Sad Path" do
    scenario "user cannot add an account with a blank name" do
      login_as(user)
      visit dashboard_path

      expect(page).to have_css("#add-account", visible: true)
      click_button "add-account"
      fill_in "name", with: ""
      fill_in "balance", with: 1000
      choose "account_type_checking"
      click_on "submit-account"

      expect(page).to have_current_path(dashboard_path)
      expect(page).to have_content("Account was not created. Please try again.")
    end

    scenario "user cannot add an account with a blank balance" do
      login_as(user)
      visit dashboard_path

      expect(page).to have_css("#add-account", visible: true)
      click_button "add-account"
      fill_in "name", with: "Account_01"
      fill_in "balance", with: ""
      choose "account_type_checking"
      click_on "submit-account"

      expect(page).to have_current_path(dashboard_path)
      expect(page).to have_content("Account was not created. Please try again.")
    end
  end
end