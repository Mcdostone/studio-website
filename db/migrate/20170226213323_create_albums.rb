class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    drop_table :events
    create_table :albums do |t|
      t.string   :name
      t.datetime :date
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string   :cover
      t.timestamps
    end
    rename_column :media, :event_id, :album_id
    rename_column :uploads, :event_id, :album_id

  end
end
