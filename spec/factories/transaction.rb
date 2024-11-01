FactoryBot.define do
  factory :transaction do
    amount { 100.00 }
    description { ["Rent", "Costco", "Amazon Purchase", "Utilities", "Birthday Money", "Texas Roadhouse", "Walmart", "Kroger", "Paycheck", "Ebay"].sample }
    # category { ["income", "expense", "transfer"].sample }
    transaction_date { Time.zone.today }
    transaction_type { rand(0..2) }
    user
    account
    category
  end
end
