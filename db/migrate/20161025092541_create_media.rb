class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :id_file

      t.timestamps null: false
    end
  end
end
