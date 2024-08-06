class User < ApplicationRecord
  before_save :downcase_email

  devise  :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # password is not required for updating a user, only for creating a new user
  validates :password, presence: true, on: :create
  validates :first_name, :last_name, :phone_number, :address, :city, :state, :zip_code, :date_of_birth, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :password, length: { minimum: 6 }, on: :create
  validates :date_of_birth, format: { with: /\d{4}-\d{2}-\d{2}/, message: "must be in the format YYYY-MM-DD" }
  validates :state, length: { is: 2 }

  private

  def downcase_email
    # This method is called to handle email case sensitivity and downcase the email before saving it to the database.
    self.email = email.downcase
  end
end
