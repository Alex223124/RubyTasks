require 'active_support/concern'

module Hater::Commentable
  extend ActiveSupport::Concern

  included do
    before_filter :comments, :only => [:show]
  end

  def comments
    @commentable = find_commentable
    @comments = @commentable.comments.arrange(:order => :created_at)
    @comment = Comment.new
  end

  private
    def find_commentable
      params[:controller].singularize.classify.constantize.find(params[:id])
    end
end
