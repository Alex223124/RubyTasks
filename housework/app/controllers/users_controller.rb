class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
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

  private
    def user_params
      params.require(:user).permit(:name, :birthday)
    end
end
