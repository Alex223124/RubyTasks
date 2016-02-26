class TasksController < ApplicationController
  before_action :set_task, only: [
    :show, :edit, :update, :destroy, :estimation_confirmed, :add_mark,
    :estimation_rejected, :estimation_added, :task_finished
  ]

  before_action :names, only: [:index, :show, :tasks_for_perform]

  def index
    @tasks_sleeping = Task.where(user_id: current_user.id, status: :sleeping)
    @tasks_waiting = Task.where(user_id: current_user.id, status: :waiting)
    @tasks_running = Task.where(user_id: current_user.id, status: :running)
    @tasks_finishing = Task.where(user_id: current_user.id, status: :finishing)
  end

  def new
    @task = Task.new
  end

  def show
    @estimation = Estimation.new if @task.sleeping?
    @mark = Mark.new if @task.finishing?
  end

  def edit
    if can_change_task?
      render :edit and return
    end

    redirect_to tasks_url, notice: 'It is not your task.'
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    if @task.save
      redirect_to tasks_url, notice: 'Task was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if can_change_task?
      if @task.update(task_params)
        redirect_to tasks_url, notice: 'Task was successfully updated' and return
      else
        render 'edit' and return
      end
    end

    redirect_to tasks_url, notice: 'It is not your task.'
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  def tasks_for_perform
    @tasks_sleeping = Task.where(user_perform_id: current_user.id, status: :sleeping)
    @tasks_waiting = Task.where(user_perform_id: current_user.id, status: :waiting)
    @tasks_running = Task.where(user_perform_id: current_user.id, status: :running)
    @tasks_finishing = Task.where(user_perform_id: current_user.id, status: :finishing)
    render 'index'
  end

  def estimation_added
    @task.estimation = Estimation.new(estimation_params)
    @task.wait
    if @task.save
      redirect_to tasks_url, notice: 'Estimation added.'
    else
      render 'edit'
    end
  end

  def estimation_confirmed
    @task.run!
    redirect_to tasks_url, notice: 'Estimation confirmed.'
  end

  def estimation_rejected
    @task.sleep!
    @task.estimation.delete
    redirect_to tasks_url, notice: 'Estimation rejected.'
  end

  def task_finished
    @task.finish!
    redirect_to tasks_url, notice: 'Task finished.'
  end

  def add_mark
    @task.mark = Mark.new(number: params[:mark][:number], user_id: current_user.id)
    redirect_to task_path, notice: 'Mark added.'
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :user_perform_id)
    end

    def estimation_params
      params.require(:estimation).permit(:end_time)
    end

    def names
      @names = {}
      User.all.each { |user| @names[user.id] = user.name }
    end

end
