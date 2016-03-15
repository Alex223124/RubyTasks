class CommentsController < ApplicationController
  def new
    @parent_id = params.delete(:parent_id)
    @commentable = find_commentable
    @comment = Comment.new( :parent_id => @parent_id,
                            :commentable_id => @commentable.id,
                            :commentable_type => @commentable.class.to_s,
                            :author_id => current_user.id)
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @commentable = find_commentable
    @comment = @commentable.comments.build(params.require(:comment).permit(:parent_id, :text))
    @comment.author_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Successfully created comment."
          redirect_to @commentable
        end
        format.js
      end
    else
      flash[:error] = "Error adding comment."
      redirect_to @commentable
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render status: 200
  end

  private
    def find_commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
end
