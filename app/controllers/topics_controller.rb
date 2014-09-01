class TopicsController < ApplicationController
  before_action :authenticate_user!, :except=>[:show,:index]


  def new
    @topic=Topic.new;    
  end

  def index
    @topics=Topic.paginate(page: params[:page])
    end

  def create
    @topic=Topic.new(topic_params)
    @topic.user_id=current_user.id
    @topic.topic_author=User.find_by_id(@topic.user_id).email
    
    if @topic.save
       redirect_to @topic
    else
      render 'new'
    end
  end
  
  def destroy
      @topic=Topic.find(params[:id])
      @topic.destroy
      redirect_to action: 'index'
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])   
    if @topic.user_id ==current_user.id
      if @topic.update_attributes(topic_params)
        @topic.user_id=current_user.id
        flash[:success] = "Profile updated"
        redirect_to @topic
      else
        render 'edit'
      end
    else 
      redirect_to @topic
  end
   end
  def show
    @topic=Topic.find(params[:id])
    @posts=@topic.posts.paginate(page: params[:page])
  end 

  private

  def topic_params
      params.require(:topic).permit(:name)
    end  
  

end
