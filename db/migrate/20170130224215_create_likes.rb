class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.timestamps
    end
	add_reference :likes, :user,  foreign_key: true
	add_reference :likes, :medium, foreign_key: true
	add_index :likes, [:user, :medium], :unique => true
  end
end