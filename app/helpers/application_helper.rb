module ApplicationHelper
	def find_vote(post)
      post.votes.exists?(user_id: current_user.id)
      @vote=Vote.find_by(post_id: post.id,user_id:current_user.id)
    end

    def cut_name(email)
    	email.slice(0..(email.index('@')-1))    	
    end

    def localtimer(topic)
    	@topic = Topic.find(params[:id])
    	@topic.created_at.localtime
  end

end
