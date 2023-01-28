FactoryBot.define do
  factory :address do
    association :purchase
    postal_code           { Faker::Address.zip }
    prefecture_id         { Faker::Number.between(from: 1, to: 47) }
    municipalities        { Faker::Address.city }
    street_number         { Faker::Address.street_name }
    building              { Faker::Name.initials(number: 2) }
    telephone_number      { Faker::Number.leading_zero_number(digits: 10) }
  end
end
