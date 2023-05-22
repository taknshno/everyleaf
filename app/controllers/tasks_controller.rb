class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to tasks_path, notice: "登録しました"
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :status, :priority, :end_date)
  end

  def set_task
     @task = Task.find(params[:id])
   end

end