class TasksController < ApplicationController
  before_action :set_user, only: [:new]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.find_by_user_id(params[:user_id])
  end

  def new
    @task = Task.new()
    @task.user_id = @user.id
  end

  def show
  end

  def edit
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description)
    end
end
