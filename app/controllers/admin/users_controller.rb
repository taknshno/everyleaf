class Admin::UsersController < ApplicationController
  include Admin::UsersHelper

  before_action :admin_only
  skip_before_action :admin_only, only: [:after_ensure]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :control]

  def index
    @users = User.all.default_order.page(params[:page])
  end

  def show
    @tasks = @user.tasks.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = I18n.t('views.messages.created_user')
      redirect_to admin_users_path
    else
      flash[:danger] = I18n.t('views.messages.input_error')
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = I18n.t('views.messages.updated_user')
      redirect_to admin_users_path
    else
      flash[:danger] = I18n.t('views.messages.update_user_failed')
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = I18n.t('views.messages.deleted_user')
      redirect_to admin_users_path
    else
      flash[:danger] = I18n.t('views.messages.delete_user_failed')
      redirect_to admin_users_path
    end
  end

  def control
    case params[:act]
    when "grant"
      if @user[:admin] == "あり"
        flash[:danger] = I18n.t('views.messages.already_admin')
      elsif @user.update_attribute(:admin, "あり")
        flash[:success] = I18n.t('views.messages.grant_admin')
      else
        flash[:danger] = I18n.t('views.messages.change_admin_failed')
      end
      redirect_to admin_users_path
    when "ensure"
      if @user[:admin] == "なし"
        flash[:danger] = I18n.t('views.messages.already_not_admin')
        redirect_to admin_users_path
      elsif @user.update_attribute(:admin, "なし")
        after_ensure
      else
        redirect_to admin_users_path
        flash[:danger] = I18n.t('views.messages.change_admin_failed')
      end
    end
  end

  private

  def set_user
    @user= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :password,
                                 :password_confirmation, :admin)
  end

  def admin_only
    unless current_user.admin == "あり"
      puts
      puts current_user.admin
      flash[:danger] = I18n.t('views.messages.not_have_access_to_admin')
      redirect_to :root
    end
  end

  def after_ensure
    if @user.id == current_user.id && @user.admin == "なし"
      redirect_to :root
    else
      redirect_to admin_users_path
    end
    flash[:success] = I18n.t('views.messages.ensure_admin')
  end
end

