class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy
  has_many :task_label_tasks, through: :task_labels, source: :task

  validates :label_name, presence: true, uniqueness: true, length: { maximum: 255 }
end
