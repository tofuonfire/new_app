Faker::Config.locale = :en

User.create!(name:  "Guest",
             bio: "",
             username: "guest",
             email: "guest@example.com",
             password:              "123456",
             password_confirmation: "123456",
             confirmed_at: Time.zone.now,
             confirmation_sent_at: Time.zone.now)

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

1.upto(50) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[0].posts.create!(image: image, caption: caption)
end

1.upto(10) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[1].posts.create!(image: image, caption: caption)
end

11.upto(20) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[2].posts.create!(image: image, caption: caption)
end

21.upto(30) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[3].posts.create!(image: image, caption: caption)
end

31.upto(40) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[4].posts.create!(image: image, caption: caption)
end

41.upto(50) do |n|
  image = open("#{Rails.root}/db/fixtures/image-#{n}.jpg")
  caption = Faker::TvShows::BojackHorseman.quote
  users[5].posts.create!(image: image, caption: caption)
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }