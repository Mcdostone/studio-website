class CreateAdminUploads < ActiveRecord::Migration
  
  def change
    create_table :admin_uploads do |t|
      t.timestamps null: false
    end
  
    add_reference :admin_uploads, :event, foreign_key: true
    add_reference :admin_uploads, :type, foreign_key: true
  end

end
