class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.column  :latlng, 'point', null: false
      t.float   :alt
      t.float   :speed
      t.float   :hdop

      t.index :created_at

      t.timestamps null: false
    end
  end
end
