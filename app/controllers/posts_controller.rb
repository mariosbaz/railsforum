class PostsController < ApplicationController
	
	def index
		@topic=Topic.find(params[:topic_id])
		@posts=Post.paginate(page: params[:page])
	end

	def new
		@topic=Topic.find(params[:topic_id])
		@post=Post.new
    render ''
	end

	def show
		@topic=Topic.find(params[:topic_id])
		@post=Post.find(params[:id],params[:topic_id])
	end
  
  	def create
  		@topic=Topic.find(params[:topic_id])
  		@post=Post.new
  		@post=current_user.posts.build(post_params)
  		@post.topic_id=@topic.id
      @post.post_author=User.find_by_id(@post.user_id).email

  respond_to do |format|
        if @post.save
          format.html { redirect_to @topic, notice: 'Post was successfully created.' }
          format.json { render action: 'show', status: :created, location: @post }

        else
          format.html { render action: 'new' }
          format.json { render json: @post.errors, status: :unprocessable_entity }
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
        	render 'show'
        else
        	render 'edit'
        end
    end

	  def destroy
  		@topic=Topic.find(params[:topic_id])
      @post=Post.find(params[:id])
	  	@post.destroy
	  end

  private

    def post_params
      params.require(:post).permit(:content)
    end
   
    def find_author
      @author=User.find_by_id(@post.user_id).email
    end
end
