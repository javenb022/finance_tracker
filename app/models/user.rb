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
  validates :date_of_birth, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }
  validates :state, length: { is: 2 }

  def grouped_checking_transactions
    checking_accounts = accounts.where(account_type: "checking")
    # This iterates over each checking account and creates a hash with the account as the key and the transactions as the value.
    checking_accounts.index_with(&:transactions)
  end

  def grouped_savings_transactions
    savings_accounts = accounts.where(account_type: "savings")
    # This iterates over each savings account and creates a hash with the account as the key and the transactions as the value.
    savings_accounts.index_with(&:transactions)
  end

  def grouped_credit_card_transactions
    credit_card_accounts = accounts.where(account_type: "credit")
    # This iterates over each credit card account and creates a hash with the account as the key and the transactions as the value.
    credit_card_accounts.index_with(&:transactions)
  end

  def recent_transactions
    transactions.sort_by(&:transaction_date).reverse.take(5)
  end

  def monthly_income
    # The sum of all transactions where the type is income and is grouped months
    income_data = initialize_month_hash

    data = transactions.find_by_sql("SELECT TO_CHAR(transaction_date, 'YYYY-MM') AS month, SUM(amount) AS total_amount FROM Transactions WHERE transaction_type = 0 GROUP BY TO_CHAR(transaction_date, 'YYYY-MM') ORDER BY month;")
    formatted_data = format_transactions(data)

    formatted_data.each_with_object(income_data) do |(month, amount), hash|
      formatted_month = Date.strptime(month, '%Y-%m').strftime('%B %Y')
      hash[formatted_month] = amount
    end
  end

  def monthly_expenses
    # The sum of all transactions where the type is income and is grouped months
    expense_data = initialize_month_hash

    data = transactions.find_by_sql("SELECT TO_CHAR(transaction_date, 'YYYY-MM') AS month, SUM(amount) AS total_amount FROM Transactions WHERE transaction_type = 1 GROUP BY TO_CHAR(transaction_date, 'YYYY-MM') ORDER BY month;")
    formatted_data = format_transactions(data)

    formatted_data.each_with_object(expense_data) do |(month, amount), hash|
      formatted_month = Date.strptime(month, '%Y-%m').strftime('%B %Y')
      hash[formatted_month] = amount
    end
  end

  def expenses_by_category
    # The sum of all transactions where the type is expense and is grouped by category, returning the category name and the total amount spent in that category.
    results = Transaction.joins(:category).where(transaction_type: 1).group('categories.name').select('categories.name AS category, SUM(transactions.amount) AS total_amount').order('total_amount DESC')
    results.map { |result| [result['category'], result['total_amount']] }
    # require 'pry'; binding.pry
  end

  def initialize_month_hash
    # Multiple iterators can cause this to be slow
    if transactions.empty?
      start_date = Date.today - 1.year
      end_date = Date.today.beginning_of_month

      all_months = (start_date.to_date..end_date.to_date).map { |date| date.strftime("%B %Y") }.uniq
      all_months.index_with { |_month| 0 }
    else
      start_date = transactions.minimum(:transaction_date).beginning_of_month
      end_date = Date.current.end_of_month

      all_months = (start_date.to_date..end_date.to_date).map { |date| date.strftime("%B %Y") }.uniq
      all_months.index_with { |_month| 0 }
    end
  end

  def format_transactions(data)
    data.map do |i|
      [i.month, i.total_amount]
    end
  end

  private

  def downcase_email
    # This method is called to handle email case sensitivity and downcase the email before saving it to the database.
    self.email = email.downcase
  end
end
