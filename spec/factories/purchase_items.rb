FactoryBot.define do
  factory :purchase_item do
    #association :user
    #association :item
    postal_code           { '114-0014' }
    prefecture_id         { Faker::Number.between(from: 1, to: 47) }
    municipalities        { Gimei.address.city.kanji }
    street_number         { Gimei.address.town.kanji }
    building              { '高橋ハウス102号室' }
    telephone_number      { Faker::Number.leading_zero_number(digits: 10) }
  end
end
