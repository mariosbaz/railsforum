class RemovePostAuthorFromPost < ActiveRecord::Migration
  def change
    remove_column :posts, :post_author, :string
  end
end
