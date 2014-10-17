require 'spec_helper'

describe Vote do

  let(:vote) { create(:vote) }
  
  it "has a valid factory" do
    expect(build(:vote)).to be_valid
  end

  context "responds correctly" do 
    it { expect(vote).to respond_to(:vote_value) }
    it { expect(vote).to respond_to(:user_id) }
    it { expect(vote).to respond_to(:post_id) }
    it { expect(vote).to respond_to(:user) }
    it { expect(vote).to respond_to(:post) }
  end

  it "has not a present user id" do
    expect(build(:vote, user_id: nil)).to have(1).errors_on(:user_id) 
  end
  
  it "has not a present post id" do
    expect(build(:vote, post_id: nil)).to have(1).errors_on(:post_id) 
  end
end