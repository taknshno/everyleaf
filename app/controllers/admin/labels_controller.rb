class Admin::LabelsController < ApplicationController
  before_action :admin_only
  before_action :set_label, only: [:edit, :update, :destroy]

  def index
    @labels = Label.all
  end

  def new
    @label = Label.new
  end

  def edit
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

  def update
    if @label.update(label_params)
      flash[:success] = I18n.t('views.messages.updated_label')
      redirect_to admin_labels_path
    else
      flash[:danger] = I18n.t('views.messages.update_label_failed')
      render :edit
    end
  end

  def destroy
    if @label.destroy
      flash[:success] = I18n.t('views.messages.deleted_label')
      redirect_to admin_labels_path
    else
      flash[:danger] = I18n.t('views.messages.delete_label_failed')
      redirect_to admin_labels_path
    end
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

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
