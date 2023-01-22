FactoryBot.define do
  factory :purchase_item do
    postal_code           { '114-0014' }
    prefecture_id         { Faker::Number.between(from: 1, to: 47) }
    municipalities        { Gimei.address.city.kanji }
    street_number         { Gimei.address.town.kanji }
    building              { '高橋ハウス102号室' }
    telephone_number      { Faker::Number.leading_zero_number(digits: 10) }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
