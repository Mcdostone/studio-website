class AddReferencesForMedia < ActiveRecord::Migration
  def change
	 add_reference :media, :event, foreign_key: true
	 add_reference :media, :type, foreign_key: true
  end
end
