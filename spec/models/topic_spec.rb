require 'spec_helper'

describe Topic do

  let(:user) { create(:user) }
  before { @topic = create(:topic, user: user) }

  context "responds correctly" do 
    it { expect(@topic).to respond_to(:name) }
    it { expect(@topic).to respond_to(:user_id) }
    it { expect(@topic).to respond_to(:posts) }
    it { expect(@topic).to respond_to(:user) }
  end

  it "has not a present name" do
    expect(build(:topic, name: nil)).to_not be_valid 
  end

  it "has a name larger than 15 characters" do
    expect(build(:topic, name: "a"*16 )).to_not be_valid 
  end

  it "has no user id present" do
    expect(build(:topic, user_id: nil)).not_to be_valid 
  end 
  
  describe "after deleting topic" do
    before :each do
      post1 = create(:post, topic: @topic)      
      post2 = create(:post, topic: @topic)      
    end

    it "deletes topic associated resource" do 
      posts = @topic.posts.to_a
      @topic.destroy
      posts.each do |post|
        expect(Post.where(id: post.id)).to be_empty
      end
    end
  end
end