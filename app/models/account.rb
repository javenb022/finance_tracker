# Description: Account model that belongs to a user and has a name, account type, balance, and currency.
# Using enum for account type (checking, savings, credit).
class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  validates :name, :account_type, :balance, :currency, presence: true

  enum account_type: { checking: 0, savings: 1, credit: 2 }

  def update_balance(transaction_data)
    if transaction_data.transaction_type == "income"
      self.balance += transaction_data.amount
    elsif transaction_data.transaction_type == "expense"
      self.balance -= transaction_data.amount
    end
    save
  end
end
