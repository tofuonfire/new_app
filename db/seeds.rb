Faker::Config.locale = :en

User.create!(name:  "Hoge",
             bio: "",
             username: "hoge",
             email: "hoge@example.com",
             password:              "hogehoge",
             password_confirmation: "hogehoge",
             confirmed_at: Time.zone.now,
             confirmation_sent_at: Time.zone.now)

99.times do |n|
  name  = Faker::TvShows::BreakingBad.character
  bio = Faker::TvShows::BreakingBad.episode
  username = "sample#{n+1}"
  email = "sample-#{n+1}@example.com"
  password = "hogehoge"
  User.create!(name:  name,
               bio: bio,
               username: username, 
               email: email,
               password:              password,
               password_confirmation: password,
               confirmed_at: Time.zone.now,
               confirmation_sent_at: Time.zone.now)
end