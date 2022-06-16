FactoryBot.define do
  factory :review do
    association :user
    association :products
    content { Faker::Lorem.characters(number: 10) }
  end
end