class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :name, :category_type, presence: true

  enum category_type: %i[other expense income transfer]
end