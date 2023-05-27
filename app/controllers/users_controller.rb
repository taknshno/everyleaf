class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
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
      flash[:danger] = I18n.t('views.messages.input_error')
      render :new
    end
  end

  def show
    @tasks = @user.tasks.page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = I18n.t('views.messages.updated_user')
      redirect_to user_path
    else
      flash[:danger] = I18n.t('views.messages.update_user_failed')
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = I18n.t('views.messages.deleted_user')
    redirect_to :root
  end

  private

  def set_user
    @user= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :password,
                                 :password_confirmation, :admin)
  end

  def user_check
    if current_user.id != @user.id
      flash[:danger] = I18n.t('views.messages.not_have_access')
      redirect_to :root
    end
  end
end
