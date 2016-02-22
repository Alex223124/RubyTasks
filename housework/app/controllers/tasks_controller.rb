class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :estimation_confirmed, :estimation_rejected]

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
    unless params[:task][:estimation].nil?
      begin
        Date.parse(params[:task][:estimation][:end_time])
        @task.estimation = Estimation.new(:end_time => Date.parse(params[:task][:estimation][:end_time]))
      rescue ArgumentError
        current_user.errors.add(:birthday, 'is an invalid estimation')
        current_user.birthday = nil
        render :action => 'show' and return
      end
    end

    if @task.update(task_params)
      @task.wait!
      redirect_to tasks_url, notice: 'Task was successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  def estimation_confirmed
    @task.run!
    redirect_to tasks_url, notice: 'Estimation confirmed'
  end

  def estimation_rejected
    @task.sleep!
    redirect_to tasks_url, notice: 'Estimation rejected'
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :user_perform_id)
    end

end
