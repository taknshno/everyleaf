class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :destroy]
  before_action :user_check, only: %i[show edit update]

  def new
    redirect_to :root if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = I18n.t('views.messages.created_user')
      redirect_to :root
    else
      flash[:danger] = I18n.t('views.messages.input')
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = I18n.t('views.messages.updated_task')
      redirect_to user_path
    else
      flash[:danger] = I18n.t('views.messages.update_task_failed')
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to :root, notice: I18n.t('views.messages.deleted_user')
  end

  private

  def set_user
    @user= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :password,
                                 :password_confirmation)
  end

  def user_check
    if current_user.id != @user.id
      flash[:danger] = I18n.t('views.messages.not_have_access')
      redirect_to :root
    end
  end
end
