class RemoveTopicAuthorFromTopic < ActiveRecord::Migration
  def change
    remove_column :topics, :topic_author, :string
  end
end
