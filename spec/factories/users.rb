FactoryBot.define do
  factory :user do
    name                { 'Sample User' }
    sequence(:username) { |n| "sample#{n}" }
    sequence(:email)    { |n| "sample#{n}@example.com" }
    password            { '123456' }
    confirmed_at { Date.today }

    trait :invalid do
      name     { '' }
      username { 'users' } # 既存のルーティング("/users")と重複するユーザーネーム
      email    { 'user@invalid' }
      password { 'bar' }
    end

    trait :guest do
      name     { 'Guest User' }
      username { 'guest' }
      email    { 'guest@example.com' }
      password { '123456' }
      guest    { true }
    end

    trait :admin do
      name     { 'Administrator' }
      username { 'admin' }
      email    { 'admin@example.com' }
      password { '123456' }
      admin    { true }
    end

    trait :unconfirmed do
      confirmed_at { nil }
    end

    trait :with_posts do
      transient do
        posts_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end
