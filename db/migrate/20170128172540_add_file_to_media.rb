class AddFileToMedia < ActiveRecord::Migration
  def change
  	add_column :media, :file, :string
  end
end
