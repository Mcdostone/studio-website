class AddMoreDetailsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :nickname, :string
  	rename_column :users, :name, :last_name
  end
end
