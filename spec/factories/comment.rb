FactoryBot.define do
  factory :comment do
    comment { Faker::Book.author }
    body { Faker::Lorem.paragraph_by_chars }
    post
  end
end
