class CreateInstagramSources < ActiveRecord::Migration
  def change
    create_table :instagram_sources do |t|

      t.string     :user_id
      t.string     :last_media_id

      t.timestamps null: false
    end
  end
end
