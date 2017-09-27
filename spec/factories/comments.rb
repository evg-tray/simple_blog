FactoryGirl.define do
  factory :comment do
    text { Faker::Lorem.characters(15) }
    association :author, factory: :user
    post
  end
end
