class AddMimetypeToTypes < ActiveRecord::Migration
  def change
  	add_column :types, :mime_types, :string
  end
end
