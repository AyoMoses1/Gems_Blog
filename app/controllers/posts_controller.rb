class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @current_user = User.find(params[:user_id])
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
    redirect_to posts_url, notice: 'Post was successfully deleted.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
