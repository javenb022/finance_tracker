require 'rails_helper'

RSpec.describe User do
  before do
    @user = described_class.create!(first_name: 'John', last_name: 'Doe', email: 'john@email.com',
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
      category = create(:category, user: @user)
      account = @user.accounts.create!(name: "Checking", balance: 4336.07, currency: "USD", account_type: 0)
      transaction = @user.transactions.create!(amount: 63.80, transaction_type: 1, category: category, transaction_date: Date.today - 1.month, account: account, description: "Bought groceries")

      expect(@user.grouped_checking_transactions).to eq({ account => [transaction] })
    end

    it "#grouped_savings_transactions" do
      category = create(:category, user: @user)
      account = @user.accounts.create!(name: "Savings", balance: 1000.00, currency: "USD", account_type: 1)
      transaction = @user.transactions.create!(amount: 100.00, transaction_type: 1, category: category, transaction_date: Date.today - 1.month, account: account, description: "Deposit")

      expect(@user.grouped_savings_transactions).to eq({ account => [transaction] })
    end

    it "#grouped_credit_card_transactions" do
      category = create(:category, user: @user)
      account = @user.accounts.create!(name: "Credit Card", balance: 0.00, currency: "USD", account_type: 2)
      transaction = @user.transactions.create!(amount: 100.00, transaction_type: 1, category: category, transaction_date: Date.today - 1.month, account: account, description: "Payment")

      expect(@user.grouped_credit_card_transactions).to eq({ account => [transaction] })
    end
  end
end
