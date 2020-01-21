class AddInterruptedToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :interrupted, :boolean, default: false, nil: false
  end
end
