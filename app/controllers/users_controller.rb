class UsersController < ApplicationController
  before_action :authenticate_user!, :except=>[:show,:index]
  
  def index
  	@users = User.paginate(page: params[:page])
    @newusers = User.all(order: 'created_at DESC', limit: 5)
  end  

  def show
  	@user = User.find(params[:id])  	
  	@mylatestposts = @user.posts.all(order:"created_at DESC", limit:10)  	
    if user_signed_in?
      @feed_items = current_user.feed.paginate(page: params[:page],
      	order:"created_at DESC",limit:10)
    end
    @users = @user.following
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
  	@title = "followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
end