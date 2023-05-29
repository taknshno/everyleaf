FactoryBot.define do
  factory :task do
    task_name { "Default_Task_1" }
    task_detail { "Default_Task_Detail_1" }
    status { "未着手" }
    priority { "高" }
    end_date { "2023-05-01" }
  end
  factory :second_task, class: Task do
    task_name { "Default_Task_2" }
    task_detail { "Default_Task_Detail_2" }
    status { "着手" }
    priority { "高" }
    end_date { "2023-05-01" }
  end
  factory :third_task, class: Task do
    task_name { "Default_Task_3" }
    task_detail { "Default_Task_Detail_3" }
    status { "未着手" }
    priority { "高" }
    end_date { "2023-05-01" }
  end
  factory :fourth_task, class: Task do
    task_name { "Default_Task_4" }
    task_detail { "Default_Task_Detail_4" }
    status { "未着手" }
    priority { "高" }
    end_date { "2023-05-01" }
  end
end
