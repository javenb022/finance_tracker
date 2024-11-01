# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all

@user1 = User.create!(first_name: "Scott", last_name: "Allen", email: "sallen@email.com", password: "password123", phone_number: "123-456-7890", address: "123 Main St", city: "New York",
                      state: "NY", zip_code: "12345", date_of_birth: "1990-11-13")
@user2 = User.create!(first_name: "Velma", last_name: "Thieme", email: "velmat@email.com", password: "password123", phone_number: "555-555-5555", address: "321 South St", city: "Dallas",
                      state: "TX", zip_code: "54321", date_of_birth: "1987-05-21")
@user3 = User.create!(first_name: "Jack", last_name: "Nickles", email: "jnickles@email.com", password: "password123", phone_number: "666-666-6666", address: "499 Sunnyside Ln", city: "Miami",
                      state: "FL", zip_code: "98765", date_of_birth: "1979-09-08")

@categories = FactoryBot.create_list(:category, 3, user: @user1)
# @accounts = FactoryBot.create_list(:account, 3, user: @user1)
@account1 = FactoryBot.create(:account, user: @user1, account_type: "checking")
@account2 = FactoryBot.create(:account, user: @user1, account_type: "savings")
@account3 = FactoryBot.create(:account, user: @user1, account_type: "credit")
@accounts = [@account1, @account2, @account3]
FactoryBot.create_list(:transaction, 17, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: 1.month.ago)
FactoryBot.create_list(:transaction, 13, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: 2.months.ago)
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Time.zone.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Time.zone.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Time.zone.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Time.zone.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Time.zone.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Time.zone.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Time.zone.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Time.zone.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Time.zone.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Time.zone.today))
FactoryBot.create_list(:transaction, 5, user: @user1, account: @accounts.sample, category: @categories.sample, transaction_date: rand(1.year.ago.to_date..Time.zone.today))
