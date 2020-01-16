class Request < ApplicationRecord
  # include AASM
  belongs_to :guest, class_name: 'User', foreign_key: 'guest_id'
  belongs_to :stream
  before_create :setup_request


  # declined   - request refused by host
  # cancelled  - request cancelled by guest
  # waiting    - waiting for response
  # queued     - request accepted. waiting for interview
  # starting   - countdown period
  # interupted - interview was interupted by failure or unexpected disconnect. attempt reconnect
  # live       - interview is live
  # finished   - interview has completed

  STATUSES = {
    declined: :declined,
    cancelled: :cancelled,
    waiting: :waiting,
    queued: :queued,
    live: :live,
    interupted: :interupted,
    finished: :finished
  }

  validates_uniqueness_of :guest_id, scope: [:stream_id]
  # validates :status, inclusion: { in: STATUSES.values }

  def setup_request
    self.status = STATUSES[:waiting]
  end

  # aasm column: 'status' do
  #   state :waiting, initial: true
  # end
end
