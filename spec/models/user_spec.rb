require 'spec_helper'

describe User do
   
  let(:user) { create(:user) }

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  context  "responds correctly" do 
    it { expect(user).to respond_to(:email) } 
    it { expect(user).to respond_to(:posts) }
    it { expect(user).to respond_to(:topics) }
    it { expect(user).to respond_to(:votes) }
  end

  it "has a present email" do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it "has no password" do
    expect(build(:user, password: nil)).not_to be_valid
  end 
  
  describe "destroy associations" do
    
  	before do
  	  @topic = create(:topic, user: user) 	  
      @post = create(:post, user: user, topic: @topic)
      @vote = create(:vote, user: user, post: @post)
  	end
        
    it "finds the associated resources in the db before deleting user" do 
      expect(Topic.find(@topic.id)).not_to eq nil 
      expect(Post.find(@post.id)).not_to eq nil 
      expect(Vote.find(@vote.id)).not_to eq nil 
  	end

  	it "deletes associated resources from the db after deleting user" do
  	  topics = user.topics.to_a
      posts = user.posts.to_a
      votes = user.votes.to_a
      user.destroy
      expect(topics).not_to be_empty       
      expect(posts).not_to be_empty 
      expect(votes).not_to be_empty 

      topics.each do |topic|
        expect(Topic.where(id: topic.id)).to be_empty
      end

      posts.each do |post|
        expect(Post.where(id: post.id)).to be_empty
      end

      votes.each do |vote|
        expect(Vote.where(id: vote.id)).to be_empty
      end
  	end
  end
end