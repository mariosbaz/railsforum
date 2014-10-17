class VotesController < ApplicationController
  before_action :authenticate_user!
  
  def create    
    @post = Post.find(votes_params[:post_id])
    @topic = Topic.find(@post.topic_id)   
    if @post.votes.exists?(user_id: current_user.id)
      flash[:notice] = "You have already Voted"
      redirect_to topic_path(@topic)
    else
      @vote = current_user.votes.build(votes_params)
      @post.score ||= 0
      if @vote.save
        flash[:notice] = "Thanks for voting"
        if @vote.vote_value == 1 
          @post.score += 1
        elsif @vote.vote_value == 0
          @post.score -= 1          
        end
        @post.save
        redirect_to topic_path(@topic)      
      end
    end    
  end  

  def destroy
    @vote = Vote.find(params[:id])
    @post =Post.find(@vote.post_id)
    @topic =Topic.find(@post.topic_id)

    # Remove the score form the post resource
    if @vote.vote_value == 1 
      @post.score -= 1
    elsif @vote.vote_value == 0
      @post.score += 1
    end     
    @post.save
    @vote.destroy
    redirect_to topic_path(@topic)
    flash[:notice] = "Now you can Vote again"
  end 

  private
  def votes_params
    params.require(:vote).permit(:vote_value, :post_id)
  end 

end
