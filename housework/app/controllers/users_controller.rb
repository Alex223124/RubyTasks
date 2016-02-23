class UsersController < ApplicationController
  include Hater::Commentable

  before_action :set_user_edit, only: :edit
  before_action :set_user_show, only: :show

  def index
    @users = User.all
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
