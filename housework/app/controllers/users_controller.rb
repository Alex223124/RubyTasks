class UsersController < ApplicationController
  include Hater::Commentable
  include UsersHelper

  before_action :set_user_edit, only: :edit
  before_action :set_user_show, only: :show

  def index
    users = current_user.parents
    users += current_user.children
    @family = {}
    users.each do |user|
      tasks = Task.where(user_perform_id: user.id, status: :finishing)

      if tasks.length == 0
        average_mark = 'no marks'
        unappreciated_tasks = 'no tasks'
        overvalued_tasks = 'no tasks'
      else
        marks = 0
        count_of_unappreciated_tasks = 0
        count_of_overvalued_tasks = 0

        tasks.each do |task|
          marks += task.mark.number
          count_of_unappreciated_tasks += 1 if is_unappreciated?(task)
          count_of_overvalued_tasks += 1 if is_overvalued?(task)
        end

        average_mark = marks.to_f / tasks.length
        unappreciated_tasks = count_of_unappreciated_tasks.to_f / tasks.length * 100
        overvalued_tasks = count_of_overvalued_tasks.to_f  / tasks.length * 100
      end

      @family[user] = { average: average_mark, unappreciated: unappreciated_tasks, overvalued: overvalued_tasks }
    end



  end

  def edit
  end

  def show
  end

  def update
    begin
      Date.parse(params[:user][:birthday])
    rescue ArgumentError
      current_user.errors.add(:birthday, 'is an invalid date')
      current_user.birthday = nil
      render :action => 'edit' and return
    end
    if current_user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def add
    member = User.find(params[:id])
    if member.has_role? :parent
      current_user.parents. << member
    else
      current_user.children << member
    end
    redirect_to family_user_path, notice: member.name + ' in your family now.'
  end

  def family
  end

  private
    def set_user_edit
      @user = current_user
    end

    def set_user_show
      @user = User.find(params[:id])
      @names = {}
      User.all.each { |user| @names[user.id] = user.name }
    end

    def user_params
      params.require(:user).permit(:name, :birthday, :avatar, :locale)
    end
end
