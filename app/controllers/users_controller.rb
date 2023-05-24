class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    redirect_to :root if logged_in?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    if params[:id].to_i == current_user.id
      @user = User.find(params[:id])
    else
      redirect_to :root
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password,
                                 :password_confirmation)
  end
end
