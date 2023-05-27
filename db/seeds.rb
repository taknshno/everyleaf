30.times do |n|
  name = Faker::Name.unique.name
  email = Faker::Internet.unique.email
  password = "password"
  User.create!(user_name: name,
               email: email,
               password: password,
               admin: false
               )
end