class Call < ApplicationRecord
  belongs_to :request
  has_one :guest, through: :request
  has_one :stream, through: :request
  has_one :host, through: :stream

  before_create :set_start_time

  def set_start_time
    self.start_time = DateTime.now
  end
end
