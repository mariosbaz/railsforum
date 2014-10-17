class ChangeBirthdayUser < ActiveRecord::Migration
  def change
  	remove_column :users, :birthday, :string
  	add_column :users, :birthday, :date, default: "1-1-1980"
  end
end


