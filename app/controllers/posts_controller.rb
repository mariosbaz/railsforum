class PostsController < ApplicationController
	before_action :authenticate_user!, :except=>[:show,:index]
  before_action :parent_topic

  def new
    @post = Post.new
  end  

  def index
    redirect_to @topic
  end

	def show
		@post = Post.find(params[:id])
    redirect_to @topic
	end

  def edit
    @post = Post.find(params[:id])    
  end
  
  def create
  	@post = current_user.posts.build(post_params)
  	@post.topic_id = @topic.id
    @post.score = 0
    respond_to do |format|
      if @post.save
        format.html { render 'show', notice: 'Post was successfully created.' }
        format.json
        format.js 
      else
        format.html { render 'show'}
      end
    end  		
  end  

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated"
      redirect_to topic_post_path(@topic,@post)
    else
      render 'edit'
    end
  end

	def destroy
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      respond_to do |format|
        if @post.destroy
          format.html {redirect_to @topic, notice: 'Post was successfully deleted.' }
          format.js
        else
          format.html { render action: 'new' }
        end
      end
    else 
      redirect_to @topic
    end     
	end

  private

    def post_params
      params.require(:post).permit(:content)
    end      
        
    def parent_topic
      @topic = Topic.find(params[:topic_id])
    end
end
