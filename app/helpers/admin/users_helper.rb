module Admin::UsersHelper
  def admin_user?
    current_user.admin == "あり"
  end
end
