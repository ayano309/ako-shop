FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.characters(number: 3) }
  end
end