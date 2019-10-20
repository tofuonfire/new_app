Faker::Config.locale = :en

# ゲストユーザー作成
User.create!(name:  "Guest User",
             bio: "",
             username: "guest",
             email: "guest@example.com",
             password:              "123456",
             password_confirmation: "123456",
             confirmed_at: Time.zone.now,
             confirmation_sent_at: Time.zone.now,
             guest: true)

1.upto(99) do |n|
  name  = Faker::TvShows::BreakingBad.character
  bio = Faker::TvShows::BreakingBad.episode
  username = "sample#{n}"
  email = "sample-#{n}@example.com"
  password = "123456"
  User.create!(name:  name,
               bio: bio,
               username: username, 
               email: email,
               password:              password,
               password_confirmation: password,
               confirmed_at: Time.zone.now,
               confirmation_sent_at: Time.zone.now)
  end

users = User.order(:created_at).take(9)

users.each_with_index do |user, n|
  user.avatar = open("#{Rails.root}/db/fixtures/avatar-#{n}.jpg")
  user.save
end

1.upto(10) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[0].posts.create!(
    image: image,
    caption: caption,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
end

21.upto(30) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[1].posts.create!(
    image: image,
    caption: caption,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
end

31.upto(40) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[2].posts.create!(
    image: image,
    caption: caption,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
end

41.upto(50) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[3].posts.create!(
    image: image,
    caption: caption,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
end

1.upto(10) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[4].posts.create!(
    image: image,
    caption: caption,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
end

11.upto(20) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[5].posts.create!(
    image: image,
    caption: caption,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
end

21.upto(30) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[6].posts.create!(
    image: image,
    caption: caption,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
end

31.upto(40) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[7].posts.create!(
    image: image,
    caption: caption,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
end

41.upto(50) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[8].posts.create!(
    image: image,
    caption: caption,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# いいね
users = User.order(:created_at)

0.upto(14) do |n|
  users[1].posts[-1].like(users[n])
end
users[1].posts[-1].unlike(users[1])

1.upto(7) do |i|
  0.upto(10) do |n|
    users[i+1].posts[-1].like(users[n])
  end
  users[i+1].posts[-1].unlike(users[i+1])
end

1.upto(7) do |i|
  0.upto(10) do |n|
    users[i].posts[-2].like(users[n])
  end
  users[i].posts[-2].unlike(users[i])
end

# 検索用の投稿
0.upto(1) do |n|
  image = open("#{Rails.root}/db/fixtures/apple-#{n}.jpg")
  caption = "apple"
  users[1].posts.create!(
    image: image,
    caption: caption,
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
end

# 管理ユーザー作成
admin = User.create!(name:  "Administrator",
                     bio: "",
                     username: "admin",
                     email: "admin@example.com",
                     password:              "123456",
                     password_confirmation: "123456",
                     confirmed_at: Time.zone.now,
                     confirmation_sent_at: Time.zone.now,
                     admin: true)

admin.avatar = open("#{Rails.root}/db/fixtures/admin.jpg")
admin.save