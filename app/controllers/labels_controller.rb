class LabelsController < ApplicationController

  def index
    @labels = Label.all
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:label_name)
  end
end
