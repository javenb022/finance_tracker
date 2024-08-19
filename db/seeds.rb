# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all

@user1 = User.create!(first_name: "Scott", last_name: "Allen", email: "sallen@email.com", password: "password123", phone_number: "123-456-7890", address: "123 Main St", city: "New York", state: "NY", zip_code: "12345", date_of_birth: "1990-11-13")
@user2 = User.create!(first_name: "Velma", last_name: "Thieme", email: "velmat@email.com", password: "password123", phone_number: "555-555-5555", address: "321 South St", city: "Dallas", state: "TX", zip_code: "54321", date_of_birth: "1987-05-21")
@user3 = User.create!(first_name: "Jack", last_name: "Nickles", email: "jnickles@email.com", password: "password123", phone_number: "666-666-6666", address: "499 Sunnyside Ln", city: "Miami", state: "FL", zip_code: "98765", date_of_birth: "1979-09-08")

@categories = FactoryBot.create_list(:category, 3, user: @user1)
@accounts = FactoryBot.create_list(:account, 3, user: @user1)
FactoryBot.create_list(:transaction, 17, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: 1.month.ago)
FactoryBot.create_list(:transaction, 13, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: 2.months.ago)
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Date.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Date.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Date.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Date.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Date.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Date.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Date.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Date.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Date.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Date.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Date.today))
# @recent_transactions = FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: Date.today)
# @recent_transactions = FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: Date.today)
# @recent_transactions = FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: Date.today)
# @account1 = @user1.accounts.create!(name: "Checking", account_type: 0, balance: 1000, currency: "USD")
# @account2 = @user1.accounts.create!(name: "Savings", account_type: 1, balance: 5000, currency: "USD")
# @account3 = @user2.accounts.create!(name: "Checking", account_type: 0, balance: 2000, currency: "USD")
# @account4 = @user2.accounts.create!(name: "Savings", account_type: 1, balance: 3000, currency: "USD")
# @account5 = @user2.accounts.create!(name: "Credit Card", account_type: 2, balance: 500, currency: "USD")
# @account6 = @user3.accounts.create!(name: "Checking", account_type: 0, balance: 1500, currency: "USD")

# @category1 = @user1.categories.create!(name: "Groceries", category_type: 1)
# @category2 = @user1.categories.create!(name: "Gas", category_type: 1)
# @category3 = @user1.categories.create!(name: "Entertainment", category_type: 1)
# @category4 = @user1.categories.create!(name: "Rent", category_type: 1)
# @category5 = @user1.categories.create!(name: "Paycheck", category_type: 2)

# @category6 = @user2.categories.create!(name: "Groceries", category_type: 1)
# @category7 = @user2.categories.create!(name: "Utilities", category_type: 1)
# @category8 = @user2.categories.create!(name: "Netflix", category_type: 1)
# @category9 = @user2.categories.create!(name: "Paycheck", category_type: 2)

# @category10 = @user3.categories.create!(name: "Transfer to Savings", category_type: 3)
# @category11 = @user3.categories.create!(name: "Car Payment", category_type: 1)
# @category12 = @user3.categories.create!(name: "Paycheck", category_type: 2)

# @transaction1 = @user1.transactions.create!(account_id: @account1.id, category_id: @category1.id, amount: 100.00, transaction_date: "2022-01-01", description: "Groceries", transaction_type: 1)
# @transaction2 = @user1.transactions.create!(account_id: @account1.id, category_id: @category2.id, amount: 50.00, transaction_date: "2022-01-01", description: "Gas", transaction_type: 1)
# @transaction3 = @user1.transactions.create!(account_id: @account1.id, category_id: @category3.id, amount: 200.00, transaction_date: "2022-01-03", description: "Concert tickets", transaction_type: 1)
# @transaction4 = @user1.transactions.create!(account_id: @account1.id, category_id: @category4.id, amount: 1000.00, transaction_date: "2022-01-04", description: "Rent", transaction_type: 1)
# @transaction5 = @user1.transactions.create!(account_id: @account1.id, category_id: @category5.id, amount: 2000.00, transaction_date: "2022-01-05", description: "Paycheck", transaction_type: 0)

# @transaction6 = @user2.transactions.create!(account_id: @account3.id, category_id: @category6.id, amount: 150.00, transaction_date: "2022-01-01", description: "Groceries", transaction_type: 1)
# @transaction7 = @user2.transactions.create!(account_id: @account3.id, category_id: @category7.id, amount: 100.00, transaction_date: "2022-01-02", description: "Electric bill", transaction_type: 1)
# @transaction8 = @user2.transactions.create!(account_id: @account3.id, category_id: @category8.id, amount: 15.00, transaction_date: "2022-01-03", description: "Netflix subscription", transaction_type: 1)
# @transaction9 = @user2.transactions.create!(account_id: @account3.id, category_id: @category9.id, amount: 3000.00, transaction_date: "2022-01-04", description: "Paycheck", transaction_type: 0)

# @transaction10 = @user3.transactions.create!(account_id: @account6.id, category_id: @category10.id, amount: 500.00, transaction_date: "2022-01-01", description: "Transfer to Savings", transaction_type: 2)
# @transaction11 = @user3.transactions.create!(account_id: @account6.id, category_id: @category11.id, amount: 300.00, transaction_date: "2022-01-02", description: "Car Payment", transaction_type: 1)
# @transaction12 = @user3.transactions.create!(account_id: @account6.id, category_id: @category12.id, amount: 1500.00, transaction_date: "2022-01-03", description: "Paycheck", transaction_type: 0)