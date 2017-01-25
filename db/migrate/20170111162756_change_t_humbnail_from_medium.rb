class ChangeTHumbnailFromMedium < ActiveRecord::Migration
  def change
  	rename_column :media, :thumbnail, :thumbnail_url
  end
end
