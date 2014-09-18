class RemoveVotedownNameFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :vote_down, :integer
  end
end
