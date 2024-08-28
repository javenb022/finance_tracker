FactoryBot.define do
  factory :transaction do
    amount { 100.00 }
    description { Faker::Lorem.sentence }
    # category { ["income", "expense", "transfer"].sample }
    transaction_date { Time.zone.today }
    transaction_type { rand(0..2) }
    user
    account
    category
  end
end
