class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :category

  validates :amount, :transaction_type, :transaction_date, presence: true

  enum transaction_type: { income: 0, expense: 1, transfer: 2 }

  def set_default_category
    self.category_id ||= {
      "income" => 1,
      "expense" => 2
    }.fetch(transaction_type, 0)
  end
end
