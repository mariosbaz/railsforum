class ChangeDefaultValuesUser < ActiveRecord::Migration
  def change
     remove_column :users, :gender
     remove_column :users, :birthday
     add_column :users, :gender, :string, default: "unknown"
     add_column :users, :birthday, :string, default: "unknown"

  end
end
