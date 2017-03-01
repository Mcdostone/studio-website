class AddUrlToMedia < ActiveRecord::Migration[5.0]
  def change
    add_column :media, :url, :string
  end
end
