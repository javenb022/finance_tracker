require 'rails_helper'

RSpec.describe User do
  before do
    Timecop.freeze(Time.zone.local(2024, 8, 1))
  end
  let!(:user) do
    create(:user, first_name: 'John', last_name: 'Doe', email: 'john@email.com',
                  password: 'password123', phone_number: '123-456-7890',
                  address: '123 Main St', city: 'Anytown', state: 'NY',
                  zip_code: '12345', date_of_birth: '2022-01-01')
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:zip_code) }
    it { is_expected.to validate_presence_of(:date_of_birth) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_length_of(:state).is_equal_to(2) }
    it { is_expected.to allow_value('2022-01-01').for(:date_of_birth) }
    it { is_expected.not_to allow_value('2022-13-01').for(:date_of_birth) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:accounts).dependent(:destroy) }
    it { is_expected.to have_many(:categories).dependent(:destroy) }
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
  end

  describe "instance methods" do
    it "#grouped_checking_transactions" do
      category = create(:category, user:)
      account = user.accounts.create!(name: "Checking", balance: 4336.07, currency: "USD", account_type: 0)
      transaction = user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 1.month, account:, description: "Bought groceries")

      expect(user.grouped_checking_transactions).to eq({ account => [transaction] })
    end

    it "#grouped_savings_transactions" do
      category = create(:category, user:)
      account = user.accounts.create!(name: "Savings", balance: 1000.00, currency: "USD", account_type: 1)
      transaction = user.transactions.create!(amount: 100.00, transaction_type: 1, category:, transaction_date: Time.zone.today - 1.month, account:, description: "Deposit")

      expect(user.grouped_savings_transactions).to eq({ account => [transaction] })
    end

    it "#grouped_credit_card_transactions" do
      category = create(:category, user:)
      account = user.accounts.create!(name: "Credit Card", balance: 0.00, currency: "USD", account_type: 2)
      transaction = user.transactions.create!(amount: 100.00, transaction_type: 1, category:, transaction_date: Time.zone.today - 1.month, account:, description: "Payment")

      expect(user.grouped_credit_card_transactions).to eq({ account => [transaction] })
    end

    it "#recent_transactions" do
      category = create(:category, user:)
      account = user.accounts.create!(name: "Checking", balance: 4336.07, currency: "USD", account_type: 0)
      transaction1 = user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 1.day, account:, description: "Bought groceries")
      transaction2 = user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 2.days, account:, description: "Bought groceries")
      transaction3 = user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 3.days, account:, description: "Bought groceries")
      transaction4 = user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 4.days, account:, description: "Bought groceries")
      transaction5 = user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 5.days, account:, description: "Bought groceries")
      transaction6 = user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 2.months, account:, description: "Bought groceries")
      transaction7 = user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 2.months, account:, description: "Bought groceries")

      expect(user.recent_transactions).to eq([transaction1, transaction2, transaction3, transaction4, transaction5])
      expect(user.recent_transactions).not_to include(transaction6, transaction7)
    end

    it "#monthly_income" do
      category = create(:category, user:)
      account = user.accounts.create!(name: "Checking", balance: 4336.07, currency: "USD", account_type: 0)
      user.transactions.create!(amount: 63.80, transaction_type: 0, category:, transaction_date: Time.zone.today, account:, description: "Deposit")
      user.transactions.create!(amount: 46.79, transaction_type: 0, category:, transaction_date: Time.zone.today - 2.days, account:, description: "Deposit")
      user.transactions.create!(amount: 10.42, transaction_type: 0, category:, transaction_date: Time.zone.today - 3.days, account:, description: "Deposit")
      user.transactions.create!(amount: 17.01, transaction_type: 0, category:, transaction_date: Time.zone.today - 4.days, account:, description: "Deposit")
      user.transactions.create!(amount: 22.20, transaction_type: 0, category:, transaction_date: Time.zone.today - 5.days, account:, description: "Deposit")
      user.transactions.create!(amount: 6.11, transaction_type: 0, category:, transaction_date: Time.zone.today - 2.months, account:, description: "Deposit")
      user.transactions.create!(amount: 81.05, transaction_type: 0, category:, transaction_date: Time.zone.today - 2.months, account:, description: "Deposit")

      expected = [["June 2024", 87.16], ["July 2024", 96.42], ["August 2024", 63.8]]
      actual = user.monthly_income.map { |month, amount| [month, amount.to_f] }
      expect(actual).to eq(expected)
      expect(actual).not_to include(Time.zone.today - 2.months, 0.63)
    end

    it "#monthly_expenses" do
      category = create(:category, user:)
      account = user.accounts.create!(name: "Checking", balance: 4336.07, currency: "USD", account_type: 0)
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 2.days, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 3.days, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 4.days, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 5.days, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 2.months, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 2.months, account:, description: "Bought groceries")

      expected = [["June 2024", 127.6], ["July 2024", 255.2], ["August 2024", 63.8]]
      actual = user.monthly_expenses.map { |month, amount| [month, amount.to_f] }
      expect(actual).to eq(expected)
      expect(actual).not_to include(Time.zone.today - 2.months, 0.63)
    end

    it "#initialize_month_hash" do
      category = create(:category, user:)
      account = user.accounts.create!(name: "Checking", balance: 4336.07, currency: "USD", account_type: 0)
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 2.days, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 3.days, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 4.days, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 5.days, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 2.months, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 2.months, account:, description: "Bought groceries")

      expect(user.initialize_month_hash).to eq({ Time.zone.today.strftime('%B %Y') => 0, "July 2024" => 0, "June 2024" => 0 })
    end

    it "#format_transactions" do
      category = create(:category, user:)
      account = user.accounts.create!(name: "Checking", balance: 4336.07, currency: "USD", account_type: 0)
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 2.days, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 3.days, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 4.days, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 5.days, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 2.months, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category:, transaction_date: Time.zone.today - 2.months, account:, description: "Bought groceries")
      data = user.transactions.find_by_sql("SELECT TO_CHAR(transaction_date, 'YYYY-MM') AS month, SUM(amount) AS total_amount FROM Transactions WHERE transaction_type = 1 GROUP BY TO_CHAR(transaction_date, 'YYYY-MM') ORDER BY month;")

      expected = [["2024-06", 127.6], ["2024-07", 255.2], ["2024-08", 63.8]]
      actual = user.format_transactions(data)
      actual_formatted = actual.map { |month, amount| [month, amount.to_f] }

      expect(actual_formatted).to eq(expected)
    end

    it "#expenses_by_category" do
      category1 = create(:category, user:, name: "Groceries")
      category2 = create(:category, user:, name: "Rent")
      account = user.accounts.create!(name: "Checking", balance: 4336.07, currency: "USD", account_type: 0)
      user.transactions.create!(amount: 63.80, transaction_type: 1, category: category1, transaction_date: Time.zone.today, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category: category1, transaction_date: Time.zone.today - 2.days, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category: category2, transaction_date: Time.zone.today - 3.days, account:, description: "Paid rent")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category: category2, transaction_date: Time.zone.today - 4.days, account:, description: "Paid rent")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category: category2, transaction_date: Time.zone.today - 5.days, account:, description: "Paid rent")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category: category1, transaction_date: Time.zone.today - 2.months, account:, description: "Bought groceries")
      user.transactions.create!(amount: 63.80, transaction_type: 1, category: category1, transaction_date: Time.zone.today - 2.months, account:, description: "Bought groceries")

      expected = [["Groceries", 255.2], ["Rent", 191.4]]
      actual = user.expenses_by_category
      actual_formatted = actual.map { |name, amount| [name, amount.to_f] }

      expect(actual_formatted).to eq(expected)
    end
  end
end
