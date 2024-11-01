FactoryBot.define do
  factory :account do
    name { ["Checking", "Savings", "Credit Card"].sample }
    balance { Faker::Number.decimal(l_digits: 2) }
    account_type { rand(0..2) }
    user
  end
end
