class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.find_by_user_id(params[:user_id])
  end

  def new
    @task = Task.new()
    @task.user_id = params[:user_id]
  end

  def show
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to action: 'index', notice: 'Task was successfully created.'
    else
      render 'new'
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description)
    end
end
