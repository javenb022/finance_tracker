FactoryBot.define do
  factory :account do
    name { Faker::Company.name }
    balance { Faker::Number.decimal(l_digits: 2) }
    account_type { rand(0..2) }
    user
  end
end