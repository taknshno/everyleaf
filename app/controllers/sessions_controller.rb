class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path
      flash[:success] = I18n.t('views.messages.logged_in')
    else
      redirect_to new_session_path
      flash[:danger] = I18n.t('views.messages.login_failed')
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
    flash[:success] = I18n.t('views.messages.logged_out')
  end
end
