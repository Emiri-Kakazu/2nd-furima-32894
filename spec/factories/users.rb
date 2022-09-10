FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 10, min_alpha: 4, min_numeric: 2) }
    password_confirmation { password }
    family_name           { Gimei.last.kanji }
    first_name            { Gimei.first.kanji }
    furigana_family_name  { Gimei.last.katakana }
    furigana_first_name   { Gimei.first.katakana }
    birthday              { Faker::Date.between(from: '1930-01-01', to: '2017-12-31') }
  end
end
