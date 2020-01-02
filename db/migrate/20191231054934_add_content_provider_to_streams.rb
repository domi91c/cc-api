class AddContentProviderToStreams < ActiveRecord::Migration[6.0]
  def change
    add_column :streams, :content_provider, :string
  end
end
