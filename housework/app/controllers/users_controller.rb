class UsersController < ApplicationController
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
    selected_day = params[:user]['birthday(1i)'].to_i
    selected_month = params[:user]['birthday(2i)'].to_i
    selected_year = params[:user]['birthday(3i)'].to_i
    begin
      Date.new(selected_day, selected_month, selected_year)
    rescue ArgumentError
      current_user.errors.add(:birthday, 'is an invalid date')
      current_user.birthday = nil
      render :action => 'edit' and return
    end
    if current_user.update(user_params)
      redirect_to action: 'index', notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def create_comment
    @comment = Comment.new()
    @comment.author_id = current_user.id
    @comment.commentable_id = params[:id]
    @comment.commentable_type = User
    @comment.text = params[:user][:comment][:text]

    if @comment.save
      redirect_to action: 'show'
    else
      redirect_to user_path, notice: "Comment don't create."
    end
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
