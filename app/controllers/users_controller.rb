class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def index
    @users = User.search(params[:term])
    @posts = @user.posts.order(created_at: :desc)

    respond_to :js
  end

  def show
    @user = User.find(params[:id])
    set_meta_tags title: @user.name
    @posts = @user.posts.includes(:photos, :likes, :comments)
    @posts = @user.posts.order(created_at: :desc)
    @saved = Post.joins(:bookmarks).where("bookmarks.user_id=?", current_user.id).
      includes(:photos, :likes, :comments) if @user == current_user
  end
  
  def edit
    # @user = User.find(params[:id])
  end
  
  # def send_email
  #   @sender = User.find(params[:id])
  #   @receiver = User.find(@sender.receiver_id)
  
  #   Mailer.order_send(@sender, @receiver).deliver
  #   flash[:notice] = "Email has been sent."
  #   redirect_to user_path(@user.id)
  # end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :name, :website, :bio, :email)
  end
end