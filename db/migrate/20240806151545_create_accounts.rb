class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name, null: false, default: ""
      t.integer :account_type, null: false, default: 0
      t.decimal :balance, precision: 10, scale: 2, default: 0.0
      t.string :currency, null: false, default: 'USD'
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
