class CreateStreams < ActiveRecord::Migration[6.0]
  def change
    create_table :streams do |t|
      t.integer :host_id, null: false, foreign_key: true
      t.string :content_url
      t.string :content_identifier

      t.timestamps
    end
  end
end
