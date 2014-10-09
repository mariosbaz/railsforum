class ChangeBirthdayUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :birthday, :string, default: "unknown"
  	 add_column :users, :birthday, :string, default: "unknown"
  end
end
