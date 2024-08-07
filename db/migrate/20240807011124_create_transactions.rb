class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2
      t.date :transaction_date, null: false, default: -> { 'CURRENT_DATE' }
      t.string :description, default: ''
      t.integer :transaction_type, null: false, default: 0

      t.timestamps
    end
  end
end
