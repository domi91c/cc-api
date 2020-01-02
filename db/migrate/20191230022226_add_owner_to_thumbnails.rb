class AddOwnerToThumbnails < ActiveRecord::Migration[6.0]
  def change
    add_reference :thumbnails, :owner, polymorphic: true, null: false
  end
end
