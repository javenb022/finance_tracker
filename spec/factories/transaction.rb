FactoryBot.define do
  factory :transaction do
    amount { 100.00 }
    description { Faker::Lorem.sentence }
    # category { ["income", "expense", "transfer"].sample }
    transaction_date { Date.today }
    association :user, factory: :user
    association :account, factory: :account
    association :category, factory: :category
  end
end