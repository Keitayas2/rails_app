class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @post = Post.new
    @posts = Post.all
    search = params[:search]
    @posts = @posts.joins(:user).where("body LIKE ? OR name LIKE ?", "%#{search}%", "%#{search}%") if search.present?
    @rank_posts = Post.all
    search = params[:search]
    @rank_posts = @posts.joins(:user).where("body LIKE ? OR name LIKE ?", "%#{search}%", "%#{search}%") if search.present?
    @rank_posts = @rank_posts.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}
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
    @posts = Post.all
    @comments = @post.comments
    @comment = Comment.new
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
