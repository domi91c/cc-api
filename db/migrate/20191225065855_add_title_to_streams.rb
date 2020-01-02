class AddTitleToStreams < ActiveRecord::Migration[6.0]
  def change
    add_column :streams, :title, :string
  end
end
