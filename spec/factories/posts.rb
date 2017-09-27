FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.characters(15) }
    body { Faker::Lorem.characters(50) }
    association :author, factory: :user
    public true
  end
end
