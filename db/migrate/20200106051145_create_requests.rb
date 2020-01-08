class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :status
      t.references :stream, null: false, foreign_key: true
      t.integer :guest_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
