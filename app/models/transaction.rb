class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :category

  validates :amount, :transaction_type, :transaction_date, presence: true

  enum transaction_type: %i[income expense transfer]
end