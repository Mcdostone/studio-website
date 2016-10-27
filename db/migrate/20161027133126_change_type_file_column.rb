class ChangeTypeFileColumn < ActiveRecord::Migration
  def change
  	rename_column :types, :type_file, :name
  end
end
