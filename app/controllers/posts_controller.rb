class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
    respond_to do |format|
      format.html
      format.xml { render xml: @posts }
      format.json { render json: @posts, status: :ok }
    end
  end

  def show
    @post = Post.find(params[:id])
    @current_user = current_user
    respond_to do |format|
      format.html
      format.xml { render xml: @post.comments }
      format.json { render json: @post.comments }
    end
  end

  def new
    @post = @current_user.posts.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @current_user.posts.new(post_params)
    @post.commentscounter = 0
    @post.likescounter = 0
    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = 'Post was successfully added.'
          redirect_to user_posts_path(@user)
        else
          render :new, locals: { post: @post }
        end
      end
    end
  end

  def destroy
    authorize! :delete, @post
    @post.destroy
    @current_user.postscounter -= 1
    @current_user.save
    redirect_to user_posts_path(current_user), notice: 'Post was successfully deleted.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
