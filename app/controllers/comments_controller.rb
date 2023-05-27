class CommentsController < ApplicationController
  load_and_authorize_resource


  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    respond_to do |format|
      format.json { render json: @comments }
    end
  end

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to request.referrer, notice: 'comment was successfully created.' }
        format.json { render json: @comment, status: :created }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :delete, @comment
    @post = @comment.post
    @comment.destroy
    @post.commentscounter -= 1
    @post.save
    @comment.destroy
    redirect_to user_post_path(@comment.post), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
