class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    case params[:sort_by]
    when "priority"
      @tasks = Task.all.order(priority: "ASC")
    when "end_date"
      @tasks = Task.all.order(end_date: "DESC")
    else
      @tasks = Task.all.order(created_at: "DESC")
    end
    @tasks = @tasks.page(params[:page])
  end

  def search
    key_word = params[:key_word]
    key_status = params[:key_status]

    if key_word.empty? && key_status.empty?
      @tasks = Task.all.order(created_at: "DESC")
    else
      @tasks = Task.search(params[:key_word], params[:key_status])
    end

    @tasks = @tasks.page(params[:page])
    render "index"
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to tasks_path, notice: I18n.t('views.messages.created_task')
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: I18n.t('views.messages.updated_task')
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: I18n.t('views.messages.deleted_task')
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :task_detail, :status, :priority, :end_date)
  end

  def set_task
     @task = Task.find(params[:id])
   end

end