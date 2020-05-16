# class FollowsController < ApplicationController
#   before_action :authenticate_user!

#   def create
#     @user = User.find(params[:id])
#     Follow.create(followable: user, follower: current_user)
#     redirect_to user_path(user.username), notice: "Successfully followed user"
#   end

#   def destroy
#     @user = User.find(params[:id])
#     Follow.find(followable: user, follower: current_user).destroy
#     redirect_to user_path(user.username), notice: "Successfully unfollowed user"
#   end
# end


class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(username: params[:user_id])
    Follow.create(followable: user, follower: current_user)
    redirect_to user_path(user.username), notice: "Successfully followed user"
  end

  def destroy
    user = User.find(username: params[:username])
    Follow.find(followable: user, follower: current_user).destroy
    redirect_to user_path(user.username), notice: "Successfully unfollowed user"
  end
end