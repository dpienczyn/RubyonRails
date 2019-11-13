FactoryBot.define do
  factory :post do
    author { Faker::Book.author }
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph_by_chars }
    user
  end
end
