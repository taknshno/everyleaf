class TasksController < ApplicationController
  before_action :set_tasks, only: [:index, :search]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    case params[:sort_by]
    when "priority"
      @tasks = @tasks.priority_asc
    when "end_date"
      @tasks = @tasks.end_date_desc
    else
      @tasks = @tasks.default_order
    end
    @tasks = @tasks.page(params[:page])
  end

  def search
    key_word = params[:key_word]
    key_status = params[:key_status]
    key_label_id = params[:key_label_id]

    if key_word.present? && !key_status.present? && !key_label_id.present?
      @tasks = @tasks.word_search(key_word)
    elsif !key_word.present? && key_status.present? && !key_label_id.present?
      @tasks = @tasks.status_search(key_status)
    elsif !key_word.present? && !key_status.present? && key_label_id.present?
      @tasks = @tasks.label_search(key_label_id.to_i)
    elsif key_word.present? && key_status.present? && !key_label_id.present?
      @tasks = @tasks.word_search(key_word)
      @tasks = @tasks.status_search(key_status)
    elsif key_word.present? && !key_status.present? && key_label_id.present?
      @tasks = @tasks.wor_search(key_word)
      @tasks = @tasks.label_search(key_label_id.to_i)
    elsif !key_word.present? && key_status.present? && key_label_id.present?
      @tasks = @tasks.status_search(key_status)
      @tasks = @tasks.label_search(key_label_id.to_i)
    elsif key_word.present? && key_status.present? && key_label_id.present?
      @tasks = @tasks.word_search(key_word)
      @tasks = @tasks.status_search(key_status)
      @tasks = @tasks.label_search(key_label_id.to_i)
    end
    
    @tasks = @tasks.page(params[:page])
    render "index"
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = I18n.t('views.messages.created_task')
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = I18n.t('views.messages.updated_task')
      redirect_to tasks_path
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:success] = I18n.t('views.messages.deleted_task')
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :task_detail, :status, :priority, :end_date, { label_ids: [] } )
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_tasks
    @tasks = Task.includes(:user).where(user_id: current_user.id)
  end
end