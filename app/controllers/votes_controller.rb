class VotesController < ApplicationController
  def new
    @post=Post.find(params[:post_id])
  	@vote=Vote.new
  end

  def create
    
    @post=Post.find_by(:id =>votes_params[:post_id])
    @topic=Topic.find_by(id:@post.topic_id)
    if @post.score==nil 
      @post.score=0
      @post.save
    end
    if @post.votes.exists?(:user_id => current_user.id)
      flash[:notice]= "You have already Voted"
      redirect_to topic_path(@topic)
    else
      @vote=current_user.votes.build(votes_params)
      if @vote.save
        flash[:notice]= "Thanks for voting"
        if @vote.vote_value==1 
          @post.score=@post.score+1
        elsif @vote.vote_value==0
          @post.score=@post.score-1          
        end
        @post.save
      redirect_to topic_path(@topic)
      else
        render 'new'
      end
    end    
  end

  def index
    @votes=Vote.all
  end

  def destroy  

    @vote= Vote.find(params[:id])
    @post=Post.find_by(:id =>@vote.post_id)
    @topic=Topic.find_by(id:@post.topic_id)

    #remove the score form the post resource
    if @vote.vote_value==1 
      @post.score=@post.score-1
    elsif @vote.vote_value==0
      @post.score=@post.score+1
    end     
    @post.save
    @vote.destroy
    redirect_to topic_path(@topic)
    flash[:notice]= "Now you can Vote again"
  end
  def show
  end

  private
  def votes_params
    params.require(:vote).permit(:vote_value,:post_id)
  end 

end
