class AddCoverToTypes < ActiveRecord::Migration[5.0]
  def change
	add_column :types, :cover, :string
  end
end
