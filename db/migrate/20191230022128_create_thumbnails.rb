class CreateThumbnails < ActiveRecord::Migration[6.0]
  def change
    create_table :thumbnails do |t|
      t.string :url
      t.integer :height
      t.integer :width
      t.string :size

      t.timestamps
    end
  end
end
