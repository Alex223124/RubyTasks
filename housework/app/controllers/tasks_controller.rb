class TasksController < ApplicationController
  before_action :set_task, only: [
    :show, :edit, :update, :destroy, :estimation_confirmed, :add_mark,
    :estimation_rejected, :estimation_added, :task_finished
  ]

  def index
    @tasks = Task.where(user_id: current_user.id).to_a
    @tasks += Task.where(user_perform_id: current_user.id).to_a
    @names = {}
    User.all.each { |user| @names[user.id] = user.name }
  end

  def new
    @task = Task.new
  end

  def show
    @estimation = Estimation.new if @task.sleeping?
    @mark = Mark.new if @task.finishing?
  end

  def edit
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
    if @task.update(task_params)
      redirect_to tasks_url, notice: 'Task was successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
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

end
