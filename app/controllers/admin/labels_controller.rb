class Admin::LabelsController < ApplicationController
  before_action :admin_only

  def index
    @labels = Label.all
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      flash[:success] = I18n.t('views.messages.created_label')
      redirect_to admin_labels_path
    else
      flash[:danger] = I18n.t('views.messages.input_error')
      render :new
    end
  end

  private

  def label_params
    params.require(:label).permit(:label_name)
  end

  def admin_only
    unless current_user.admin == "あり"
      flash[:danger] = I18n.t('views.messages.not_have_access_to_admin')
      redirect_to :root
    end
  end
end
