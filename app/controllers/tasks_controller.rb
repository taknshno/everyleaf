class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all

    case params[:sort_by]
    when "priority"
      @tasks = @tasks.priority_asc
    when "end_date"
      @tasks = @tasks.end_date_desc
    else
      @tasks = @tasks.default_desc
    end

    @tasks = @tasks.page(params[:page])
  end

  def search
    @tasks = Task.all

    key_word = params[:key_word]
    key_status = params[:key_status]

    if key_word.present? && key_status.present?
      @tasks = @tasks.word_search(key_word)
      @tasks = @tasks.status_search(key_status)
    elsif key_word.present? && !key_status.present?
      @tasks = @tasks.word_search(key_word)
    elsif !key_word.present? && key_status.present?
      @tasks = @tasks.status_search(key_status)
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