require 'spec_helper'

describe Post do

  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  before { @post = create(:post, user: user) } 

  context "responds correctly" do
    it { expect(@post).to respond_to(:content) }
    it { expect(@post).to respond_to(:user_id) } 
    it { expect(@post).to respond_to(:topic_id) }
    it { expect(@post).to respond_to(:user) }
    it { expect(@post).to respond_to(:topic) }
    it { expect(@post).to respond_to(:votes) }
    it { expect(@post).to respond_to(:score) }
  end

  it "has no content" do
    expect(build(:post, content: nil)).to_not be_valid 
  end

  it "is equal or larger than 500 characters" do
    expect(build(:post, content: "a" *500 )).to be_valid 
    expect(build(:post, content: "a" *501 )).to_not be_valid 
  end

  it "has no user id present" do
    expect(build(:post, user_id: nil )).to_not be_valid 
  end

  it "has no topic id present" do
    expect(build(:post, topic_id: nil)).to_not be_valid 
  end

  describe "before and after deleting post" do
    before do
      @vote1 = create(:vote, user: user, post: @post )      
      @vote2 = create(:vote, user: user2, post: @post )      
    end
    
    it "has a post associated vote" do
      expect(Vote.find(@vote1.id)).not_to eq nil
      expect(Vote.find(@vote2.id)).not_to eq nil    
    end    
   
    it "deleted votes after deleting post" do
      votes = @post.votes.to_a
      @post.destroy
      expect(votes).not_to be_empty
      votes.each do |vote|
        expect(Vote.where(id: vote.id)).to be_empty
      end
    end
  end
end