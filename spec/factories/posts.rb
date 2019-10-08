FactoryBot.define do
  factory :post do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    caption { "I love it, amazing places, very very beautiful." }
    association :user

    trait :with_comments do
      transient do
        comments_count { 5 }
      end

      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comments_count, post: post)
      end
    end

    trait :with_likes do
      transient do
        likes_count { 5 }
      end

      after(:create) do |post, evaluator|
        create_list(:like, evaluator.likes_count, post: post)
      end
    end

  end
end
