FactoryBot.define do
  factory :transaction do
    amount { 100.00 }
    description { Faker::Lorem.sentence }
    # category { ["income", "expense", "transfer"].sample }
    transaction_date { Date.today }
    transaction_type { rand(0..2) }
    association :user, factory: :user
    association :account, factory: :account
    association :category, factory: :category
  end
end