class AddBanToUsers < ActiveRecord::Migration[5.0]
  def change
	add_column :users, :ban, :boolean
	change_column_default :users, :ban, false
  end
end
