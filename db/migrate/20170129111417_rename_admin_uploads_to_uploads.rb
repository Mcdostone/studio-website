class RenameAdminUploadsToUploads < ActiveRecord::Migration[5.0]
  def change
  	rename_table :admin_uploads, :uploads
  end
end
