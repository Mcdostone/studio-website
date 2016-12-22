class AddThumbnailUrlToMedia < ActiveRecord::Migration

  def change
  	 add_attachment :media, :thumbnail
  end
end
