class ChangeDefaultValuesUser < ActiveRecord::Migration
  def change
     add_column :users, :gender, :string, default: "unknown"
     add_column :users, :birthday, :string, default: "unknown"

  end
end
