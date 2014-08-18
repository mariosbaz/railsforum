class PostsController < ApplicationController
	def index
		@posts=Post.all
	end

	def new
		@post=Post.new
	end

	def show
	end
  
  	def create
  		@post=Post.new(content: post_params,topic_id: @topic.id,user_id: current_user.id )
              render 'new'

        end
    end

	  def destroy
	  	@post=Post.find(params[:id])
	  	@post.destroy
	  end

  private

    def post_params
      params.require(:post).permit(:content)
    end

end
