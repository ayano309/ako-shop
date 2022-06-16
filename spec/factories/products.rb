FactoryBot.define do
  factory :product do
    association :category
    category_id { 1 }
    name { Faker::Lorem.characters(number: 5) }
    description { Faker::Lorem.characters(number: 20) }
    price {345}
  end
end