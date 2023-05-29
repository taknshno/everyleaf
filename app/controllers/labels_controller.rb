class LabelsController < ApplicationController
  before_action :set_label, only: [:show]

  def index
    @labels = Label.all
  end

  def show
  end

  def edit
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:label_name)
  end
end
