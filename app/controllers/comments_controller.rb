class CommentsController < ApplicationController
  load_and_authorize_resource
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user
    if @comment.save
      @user = User.find(params[:user_id])
      redirect_to user_post_path(@user, @post)
    else
      render :new
    end
  end

  def destroy
    authorize! :delete, @comment
    @comment.destroy
    redirect_to user_post_path(@comment.post), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
