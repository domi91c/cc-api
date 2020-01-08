class Cast < ApplicationRecord
  belongs_to :stream
  before_create :set_start_time

  def set_start_time
    self.start_time = DateTime.now
  end

end
