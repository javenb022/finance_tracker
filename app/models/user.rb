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

  private

  def downcase_email
    # This method is called to handle email case sensitivity and downcase the email before saving it to the database.
    self.email = email.downcase
  end
end
