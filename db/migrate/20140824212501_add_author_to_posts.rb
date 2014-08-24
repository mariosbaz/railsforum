class AddAuthorToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_author, :string
  end
end
