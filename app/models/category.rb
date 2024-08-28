class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :nullify # This will set the category_id to nil for all transactions when a category is deleted, instead of deleting the transactions

  validates :name, :category_type, presence: true

  enum category_type: { other: 0, expense: 1, income: 2, transfer: 3 }
end
