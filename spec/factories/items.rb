FactoryBot.define do
  factory :item do
    association :user
    image                 { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpeg'), 'image/jpeg') }
    item_name             { Faker::Name.initials(number: 3) }
    description           { Faker::Lorem.sentence }
    category_id           { Faker::Number.between(from: 1, to: 11) }
    condition_id          { Faker::Number.between(from: 1, to: 6) }
    pay_for_shipping_id   { Faker::Number.between(from: 1, to: 2) }
    prefecture_id         { Faker::Number.between(from: 1, to: 47) }
    days_to_ship_id       { Faker::Number.between(from: 1, to: 3) }
    price                 { Faker::Number.between(from: 300, to: 9_999_999) }
  end
end
