class SearchController < ApplicationController
  def search
    if params[:q][:q].nil?
      @users = []
    else
      @users = User.search params[:q][:q]
    end
  end
end