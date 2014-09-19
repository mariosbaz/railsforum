class PostsController < ApplicationController
	  before_action :authenticate_user!, :except=>[:show,:index]

	def index
		@topic=Topic.find(params[:topic_id])
    @vote=Vote.new
    redirect_to topic_url(@topic.id)
	end

	def new
		@topic=Topic.find(params[:topic_id])
		@post=Post.new
	end

	def show
		@topic=Topic.find(params[:topic_id])
		@post=Post.find(params[:id])
    redirect_to @topic
	end
  
  def create
    @topic=Topic.find(params[:topic_id])
  	@post=current_user.posts.build(post_params)
  	@post.topic_id=@topic.id
    @post.score=0
    @vote=Vote.new
    respond_to do |format|
      if @post.save
        format.html { render 'show', notice: 'Post was successfully created.' }
        format.json
        format.js
      else
        format.html { render 'show' }
      end
    end  			
  		
  end

  def edit
    @topic=Topic.find(params[:topic_id])
    @post=Post.find(params[:id])    
  end

  def update
    @topic=Topic.find(params[:topic_id])
    @post=Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success]="Post updated"
      redirect_to topic_post_path(@topic,@post)
    else
      render 'edit'
    end
  end

	def destroy
    @topic=Topic.find(params[:topic_id])
    @post=Post.find(params[:id])
    respond_to do |format|
      if @post.destroy
        format.html {redirect_to @topic, notice: 'Post was successfully deleted.' }
        format.js
      else
        format.html { render action: 'new' }
      end
    end     
	end


  private

    def post_params
      params.require(:post).permit(:content)
    end      
        
end
