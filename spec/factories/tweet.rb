FactoryBot.define do
  factory :tweet do
    comment { Faker::Lorem.word }
    user_id { Faker::Number.number(10) }
  end
end