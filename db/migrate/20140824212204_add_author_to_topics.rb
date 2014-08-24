class AddAuthorToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :topic_author, :string
  end
end
