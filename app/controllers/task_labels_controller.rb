class TaskLabelsController < ApplicationController
  def create
    task_label = current_user.task_labels.create(task_id: params[:task_id])
    redirect_to tasks_path
  end

  def destroy
    task_label = current_user.task_labels.find_by(id: params[:id]).destroy
    redirect_to tasks_path
  end
end
