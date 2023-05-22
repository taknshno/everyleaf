class Task < ApplicationRecord
  validates :task_name,  presence: true, length: { maximum: 60 }
  validates :status,  inclusion: { in: [1,2,3] }
  validates :priority,  inclusion: { in: [1,2,3] }
end
