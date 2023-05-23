class Task < ApplicationRecord
  validates :task_name,  presence: true, length: { maximum: 60 }
  validates :task_detail,  presence: true, length: { maximum: 256 }
  validates :status,  inclusion: { in: ['未着手', '着手','完了'] }
  validates :priority,  inclusion: { in: ['高', '中', '低'] }

  enum status: { 未着手: 1, 着手: 2, 完了: 3 }
  enum priority: { 高: 1, 中: 2, 低: 3 }
end
