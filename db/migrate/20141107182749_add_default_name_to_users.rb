class AddDefaultNameToUsers < ActiveRecord::Migration
	def up
	  change_column :users, :name, :string, default: "Unknown"
	end

	def down
	  change_column :users, :name, :string
	end
end
