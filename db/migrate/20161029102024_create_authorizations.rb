class CreateAuthorizations < ActiveRecord::Migration
  def change
    
    create_table :authorizations do |t|
      t.string :name
  	end

		remove_column :users, :admin
		add_reference :users, :authorization, foreign_key: true

		Authorization.create :name => 'admin'
		Authorization.create :name => 'author'
		Authorization.create :name => 'viewer'
  end
end
