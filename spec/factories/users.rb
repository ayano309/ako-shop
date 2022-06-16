FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 4) }
    email { Faker::Internet.email }
    postal_code{'1970003'}
    prefecture_code{'東京都'}
    city{'福生市'}
    street{'熊川'}
    other_address{'その他'}
    phone{'07012345678'}
    password { 'password' }
    password_confirmation { 'password' }
  end
end