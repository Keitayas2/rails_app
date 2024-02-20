class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save!
      redirect_to root_path
    else
      redirect_to new_post_path
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to post_path(post)
    else
      redirect_to edit_post_path(post)
    end
  end

  private
  def post_params
    params.require(:post).permit(:body, :image)
  end

end