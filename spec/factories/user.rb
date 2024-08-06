FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    address { Faker::Address.street_address }
    zip_code { Faker::Address.zip_code }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    password { Faker::Internet.password(min_length: 6) }
  end
end
