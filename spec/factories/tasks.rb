FactoryBot.define do
  factory :task do
    task_name { "Factoryで作ったデフォルトのタスク名1" }
    task_detail { "Factoryで作ったデフォルトのタスクの詳細1" }
    status { 1 }
    priority { 1 }
    end_date { "2023-05-01" }
  end
end
