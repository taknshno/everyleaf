class Task < ApplicationRecord
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  enum status: { 未着手: 1, 着手: 2, 完了: 3 }
  enum priority: { 高: 1, 中: 2, 低: 3 }

  validates :task_name,  presence: true, length: { maximum: 60 }
  validates :task_detail,  presence: true, length: { maximum: 256 }

  scope :default_order, -> { order("tasks.created_at DESC") }
  scope :priority_asc, -> { order("tasks.priority ASC") }
  scope :end_date_desc, -> { order("tasks.end_date DESC") }

  scope :word_search, -> (key_word){ where("task_name LIKE ?", "%#{key_word}%") }
  scope :status_search, -> (key_status){ where(status: key_status) }
end