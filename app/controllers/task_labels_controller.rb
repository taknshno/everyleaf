class TaskLabelsController < ApplicationController
  def create
    task_label = current_user.task_labels.create(task_id: params[:task_id])
    redirect_to tasks_path
    notice: "#{task_label.task.task_name}へ「#{task_label.label.label_name}」をつけました。"
  end

  def destroy
    task_label = current_user.task_labels.find_by(id: params[:id]).destroy
    redirect_to tasks_path
    notice: "#{task_label.task.task_name}の「#{task_label.label.label_name}」を外しました。"
  end
end
