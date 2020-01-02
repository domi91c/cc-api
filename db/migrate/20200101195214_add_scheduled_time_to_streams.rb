class AddScheduledTimeToStreams < ActiveRecord::Migration[6.0]
  def change
    add_column :streams, :scheduled_time, :datetime
  end
end
