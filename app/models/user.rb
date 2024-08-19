# This class is used to define the User model, which is used to store user data in the database.
# The User model is used to store user data such as first name, last name, email, phone number, address, city, state, zip code, date of birth, and password.
# This model also includes validations for the user data, such as presence, uniqueness, and length validations.
class User < ApplicationRecord
  before_save :downcase_email
  has_many :accounts, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :transactions, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # password is not required for updating a user, only for creating a new user
  validates :password, presence: true, on: :create
  validates :first_name, :last_name, :phone_number, :address, :city, :state, :zip_code, :date_of_birth, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :password, length: { minimum: 6 }, on: :create
  validates :date_of_birth, format: { with: /\d{4}-\d{2}-\d{2}/ }
  validates :state, length: { is: 2 }


  def grouped_checking_transactions
    checking_accounts = accounts.where(account_type: "checking")
    # This iterates over each checking account and creates a hash with the account as the key and the transactions as the value.
    transactions_by_account = checking_accounts.each_with_object({}) do |account, hash|
      hash[account] = account.transactions
    end
    transactions_by_account
  end

  def grouped_savings_transactions
    savings_accounts = accounts.where(account_type: "savings")
    # This iterates over each savings account and creates a hash with the account as the key and the transactions as the value.
    transactions_by_account = savings_accounts.each_with_object({}) do |account, hash|
      hash[account] = account.transactions
    end
    transactions_by_account
  end

  def grouped_credit_card_transactions
    credit_card_accounts = accounts.where(account_type: "credit")
    # This iterates over each credit card account and creates a hash with the account as the key and the transactions as the value.
    transactions_by_account = credit_card_accounts.each_with_object({}) do |account, hash|
      hash[account] = account.transactions
    end
    transactions_by_account
  end

  def recent_transactions
    transactions.sort_by(&:transaction_date).reverse.take(5)
  end

  def monthly_income
    # The sum of all transactions where the type is income and is grouped months
    data = transactions.find_by_sql("SELECT TO_CHAR(transaction_date, 'YYYY-MM') AS month, SUM(amount) AS total_amount FROM Transactions WHERE transaction_type = 0 GROUP BY TO_CHAR(transaction_date, 'YYYY-MM') ORDER BY month;")
    formatted_data = data.map do |i|
      [i.month, i.total_amount]
    end
    formatted_data
  end

  private

  def downcase_email
    # This method is called to handle email case sensitivity and downcase the email before saving it to the database.
    self.email = email.downcase
  end
end
