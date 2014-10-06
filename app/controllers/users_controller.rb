class UsersController < ApplicationController
  before_action :authenticate_user!, :except=>[:show,:index]
  
  def index
  	@users=User.paginate(page: params[:page])
    @newusers = User.all(:order => 'created_at DESC', :limit => 5)
  end  

  def show
  	@user=User.find(params[:id])  	
  	@mylatestposts=@user.posts.all(order:"created_at DESC", limit:10)  	
  	
  end
  
end