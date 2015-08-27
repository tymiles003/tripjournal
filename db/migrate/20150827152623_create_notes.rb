class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|

      t.integer :kind, default: 0, null: false
      t.string  :title
      t.string  :text
      t.string  :image_url
      t.string  :source_url
      t.string  :source_id
      t.string  :author

      t.column  :latlng, :point

      t.timestamps null: false
    end
  end
end
