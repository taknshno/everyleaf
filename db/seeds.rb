30.times do |n|
  name = Faker::Name.unique.name
  email = Faker::Internet.unique.email
  password = "password"
  admin = ["あり", "なし"].sample
  User.create!( user_name: name,
                email: email,
                password: password,
                admin: admin
               )
end

30.times do |n|
  label_name = "Label_#{n}"
  Label.create!(
                  label_name: label_name
                )
end

30.times do |n|
  task_name = Faker::Lorem.sentence(word_count: 2)
  task_detail = Faker::Lorem.sentence(word_count: 25)
  status = ["未着手", "着手", "完了"].sample
  priority = ["高", "中", "低"].sample
  end_date = Faker::Date.between(from: Date.today, to: 100.days.after)
  user_id = User.ids.sample
  label_ids = Label.ids.sample(rand(0..3))
  Task.create!(
                task_name: task_name,
                task_detail: task_detail,
                status: status,
                priority: priority,
                end_date: end_date,
                user_id: user_id,
                label_ids: label_ids
               )
end