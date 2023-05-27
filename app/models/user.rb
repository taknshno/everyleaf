class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  enum admin: { あり: true, なし: false }

  validates :user_name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, length: { minimum: 6 }

  scope :default_order, -> { order("users.id ASC") }
end
