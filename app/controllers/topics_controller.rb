class TopicsController < ApplicationController
  before_action :authenticate_user!, :except=>[:show, :index]

  def new
    @topic = Topic.new    
  end

  def index
    @topics = Topic.paginate(page: params[:page], order: 'created_at DESC')
    @newtopics = Topic.all(order: "created_at DESC", limit: 5)
    @oldtopics = Topic.all(order: "created_at ASC", limit: 5)
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.paginate(page: params[:page], order: 'created_at DESC')
  end 

  def edit
    @topic = Topic.find(params[:id])
  end

  def create
    @topic = current_user.topics.build(topic_params)    
    if @topic.save
       redirect_to @topic
    else
      render 'new'
    end
  end  

  def update
    @topic = Topic.find(params[:id])       
    if @topic.user_id == current_user.id
      if @topic.update_attributes(topic_params)
        @topic.user_id = current_user.id
        flash[:success] = "Topic updated"
        redirect_to @topic
      else
        render 'edit'
      end
    else 
      redirect_to @topic
    end
   end

  def destroy
    @topic = Topic.find(params[:id])
    if @topic.user_id == current_user.id
      @topic.destroy
    end
    redirect_to action: 'index'
  end  

  private

  def topic_params
    params.require(:topic).permit(:name)
  end     

end
