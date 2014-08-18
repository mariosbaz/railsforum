class TopicsController < ApplicationController
  before_action :authenticate_user!


  def new
    @topic=Topic.new;
  end

  def index
    @topics=Topic.all;
  end

  def create
    @topic=Topic.new(topic_params)
    @topic.user_id=current_user.id
    if @topic.save
       redirect_to @topic
    else
      render 'new'
    end
  end
  
  def destroy
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
  end 

  private

  def topic_params
      params.require(:topic).permit(:name)
    end  
  
end
