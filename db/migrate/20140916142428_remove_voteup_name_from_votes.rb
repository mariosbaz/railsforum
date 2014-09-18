class RemoveVoteupNameFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :vote_up, :integer
  end
end
