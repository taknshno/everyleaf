FactoryBot.define do
  factory :user do
    user_name { "John Smith" }
    email { "john@example.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
    admin { false }
  end
  factory :admin_user, class: User do
    user_name { "Steve Johnson" }
    email { "steve@example.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
    admin { true }
  end
end
