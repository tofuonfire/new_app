FactoryBot.define do
  factory :comment do
    content { 'I like it.' }
    association :post
    association :user
  end
end
