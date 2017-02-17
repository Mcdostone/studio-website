class CleanMediaTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :media, :thumbnail_url
  end
end
