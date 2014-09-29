require 'spec_helper'

describe VotesController do
  describe 'authenticated users' do
    before :each do
      @user = create(:user)
      sign_in @user
      @topic = create(:topic)
      @post = create(:post, user: @user, topic: @topic)
    end
    describe 'POST #create' do
      context "with valid attributes" do
        it "saves the vote in the database" do
          expect{ 
            post :create, vote: attributes_for(:vote, 
            	post_id: @post.id, user_id: @user.id) 
            }.to change(Vote, :count).by(1)

	      expect{ 
	        post :create, vote: attributes_for(:vote, 
	          post_id: @post.id, user_id: @user.id) 
	          }.to_not change(Vote, :count).by(1)         
	    end
	      
	    it "adds +1 to the @post score" do         
	      expect(@post.score).to eq (0)
	      post :create, vote: attributes_for(:vote,
	        vote_value: 1, post_id: @post.id, user_id: @user.id)
	      @post.reload
	      expect(@post.score).to eq (1)
	    end 

	    it "subtracks -1 from the @post score" do         
	      expect(@post.score).to eq (0)
	      post :create, vote: attributes_for(:vote,
	        vote_value: 0, post_id: @post.id, user_id: @user.id)
	      @post.reload
	      expect(@post.score).to eq (-1)
	    end 

	    it "redirects to posts parent topic template" do
	      post :create, vote: attributes_for(:vote, 
	        post_id: @post.id, user_id: @user.id)          
	      expect(response).to redirect_to topic_path(assigns[:topic])
	    end
	  end

	  context "with invalid attributes" do
	    it "doesn't save the second vote in the database" do 
	      expect{ 
	        post :create, vote: attributes_for(:vote, 
	          post_id: @post.id, user_id: @user.id) 
	         }.to change(Vote, :count).by(1)

	      expect{ 
	        post :create, vote: attributes_for(:vote, 
	          post_id: @post.id, user_id: @user.id) 
	         }.to_not change(Vote, :count).by(1)  
	    end
	  end
	end	

	describe "DELETE #destroy" do
	  before :each do
	    @vote = create(:vote, user: @user, post: @post )      
	  end

	  it "changes the @post score correctly" do
	    expect(@post.score).to eq (0)
	    delete :destroy, id: @vote
	    @post.reload
	    expect(@post.score).to eq(-1)
	  end

	  it "deletes the vote" do
	    expect{ delete :destroy, id: @vote
	      }.to change(Vote, :count).by(-1)
	  end

	  it "redirects to the parent topic" do
	    delete :destroy, id: @vote
	    expect(response).to redirect_to topic_url(@topic)
	  end
	end
  end

  describe 'guests' do
    describe "POST #create" do
      it "requires login" do
      	post :create, vote: attributes_for(:vote)
      	expect(response).to redirect_to new_user_session_url
      end
    end

    describe "DELETE #destroy" do
      it "requires login" do
      	delete :destroy, id: create(:vote)
      	expect(response).to redirect_to new_user_session_url
      end
    end
  end
end