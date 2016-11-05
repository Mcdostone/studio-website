class ChangeDateToEvents < ActiveRecord::Migration
  def change
	rename_column :events, :date, :date_event
  end
end
