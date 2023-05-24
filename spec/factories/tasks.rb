FactoryBot.define do
  factory :task do
    task_name { "Factoryで作ったデフォルトのタスク名1" }
    task_detail { "Factoryで作ったデフォルトのタスクの詳細1" }
    status { "未着手" }
    priority { "高" }
    end_date { "2023-05-01" }
  end
  factory :second_task, class: Task do
    task_name { "Factoryで作ったデフォルトのタスク名2" }
    task_detail { "Factoryで作ったデフォルトのタスクの詳細2" }
    status { "着手" }
    priority { "高" }
    end_date { "2023-05-01" }
  end
  factory :third_task, class: Task do
    task_name { "Factoryで作ったデフォルトのタスク名3" }
    task_detail { "Factoryで作ったデフォルトのタスクの詳細3" }
    status { "未着手" }
    priority { "高" }
    end_date { "2023-05-01" }
  end
  factory :fourth_task, class: Task do
    task_name { "Factoryで作ったデフォルトのタスク名4" }
    task_detail { "Factoryで作ったデフォルトのタスクの詳細4" }
    status { "未着手" }
    priority { "高" }
    end_date { "2023-05-01" }
  end
end
