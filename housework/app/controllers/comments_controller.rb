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
    @commentable = find_commentable
    @comment = @commentable.comments.build(params.require(:comment).permit(:parent_id, :text))
    @comment.author_id = current_user.id
    if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to @commentable
    else
      flash[:error] = "Error adding comment."
      redirect_to @commentable
    end
  end

  def destroy
    @comment.destroy
    redirect_to user_path, notice: 'Comment was successfully destroyed.'
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
