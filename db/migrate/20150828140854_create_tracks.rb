class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.text :json

      t.timestamps null: false
    end
  end
end
