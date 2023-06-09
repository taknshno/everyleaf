class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  before_update :not_change_last_admin
  before_destroy :not_delete_last_admin

  enum admin: { あり: true, なし: false }

  validates :user_name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, length: { minimum: 6 }

  scope :default_order, -> { order("users.id ASC") }

  private

  def not_change_last_admin
    throw :abort if User.where(admin: true).count == 1 && self.will_save_change_to_admin?(from: "あり", to: "なし")
  end

  def not_delete_last_admin
    throw :abort if User.where(admin: true).count == 1 && self.admin == "あり"
  end
end
