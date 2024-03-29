class LikesController < ApplicationController
  def create
    like = current_user.likes.create(post_id: params[:post_id])
    redirect_to root_path
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    like.destroy
    redirect_to root_path
  end

end
