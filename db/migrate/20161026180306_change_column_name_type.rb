class ChangeColumnNameType < ActiveRecord::Migration

  def change
	rename_column :types, :type, :type_file
  end
end
