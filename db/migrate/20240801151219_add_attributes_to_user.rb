# This migration adds attributes to the User model. These attributes are first_name, last_name, phone_number, address, city, state, zip_code, and date_of_birth.
# These attributes are required for the user to sign up. The user will not be able to sign up without these attributes.
class AddAttributesToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :phone_number, null: false, default: ""
      t.string :address, null: false, default: ""
      t.string :city, null: false, default: ""
      t.string :state, null: false, default: ""
      t.string :zip_code, null: false, default: ""
      t.date :date_of_birth, null: false, default: ""
    end
  end
end
