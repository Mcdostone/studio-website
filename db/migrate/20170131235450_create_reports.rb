class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :message
      t.timestamps
    end

    add_reference :reports, :user, foreign_key: true  
    add_reference :reports, :medium, foreign_key: true  
  end
end
