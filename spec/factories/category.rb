FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word }
    category_type { rand(0..3) }
  end
end
