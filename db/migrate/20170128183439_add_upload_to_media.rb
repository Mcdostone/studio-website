class AddUploadToMedia < ActiveRecord::Migration
  def change
  	remove_column :media, :id_file
	add_reference :media, :upload, foreign_key: true
  end
end
