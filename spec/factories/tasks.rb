FactoryBot.define do
  factory :task do
    task_name { "Factoryで作ったデフォルトのタスク名1" }
    status { 2 }
    priority { 2 }
    end_date { "2023-05-01" }
  end
end
