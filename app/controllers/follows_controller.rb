class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:id])
    Follow.create(followable: user, follower: current_user)
    redirect_to user_path, notice: "Successfully followed user"
  end

  def destroy
    user = User.find(params[:id])
    Follow.find_by(followable: user, follower: current_user).destroy
    redirect_to user_path, notice: "Successfully unfollowed user"
  end
end