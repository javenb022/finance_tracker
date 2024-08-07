class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, default: ''
      t.integer :category_type, null: false, default: 0

      t.timestamps
    end
  end
end
