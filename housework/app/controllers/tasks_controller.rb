class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @category = Category.new
    @categories = Category.all
    @tasks = Task.where(user_id: current_user.id).to_a
    @tasks + Task.where(user_perform_id: current_user.id).to_a
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

  def choose_category
    @category = Category.new(category_params)

  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :user_perform_id)
    end

    def category_params
      params.require(:category).(:name)
    end
end
