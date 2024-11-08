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
    scenario "user can add an account" do
      login_as(user)

      click_on "Add Account"
      fill_in "account_ame", with: "Checking_72"
      fill_in "balance", with: 1000
      click_on "Create Account"

      expect(page).to have_current_path(dashboard_path)
      expect(page).to have_content("Checking_72")
      expect(page).to have_content("$1000.00")
    end

    scenario
  end
end