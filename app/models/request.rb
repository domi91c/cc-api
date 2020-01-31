class Request < ApplicationRecord
  # include AASM
  belongs_to :guest, class_name: 'User', foreign_key: 'guest_id'
  belongs_to :stream
  has_one :host, class_name: 'User', foreign_key: 'guest_id', through: :stream
  has_many :calls

  before_create :setup_request

  STATUSES = {
    declined: :declined,
    cancelled: :cancelled,
    waiting: :waiting,
    queued: :queued,
    live: :live,
    # interrupted: :interrupted,
    finished: :finished
  }

  ACTIVE_STATUSES = %w(waiting queued starting live)
  INACTIVE_STATUSES = %w(declined cancelled finished)

  # TODO: active shouldn't have interrupted requests.
  scope :active, -> { where(status: ACTIVE_STATUSES) }
  scope :interrupted, -> { where(status: ACTIVE_STATUSES, interrupted: true) }

  # declined     - request refused by host
  # cancelled    - request cancelled by guest
  # waiting      - waiting for response
  # queued       - request accepted. waiting for interview
  # starting     - countdown period
  ## interrupted - interview was interupted by failure or unexpected disconnect. attempt reconnect
  # live         - interview is live
  # finished     - interview has completed


  validates_uniqueness_of :guest_id, scope: [:stream_id]
  # validates :status, inclusion: { in: STATUSES.values }

  def setup_request
    self.status = STATUSES[:waiting]
  end

  # aasm column: 'status' do
  #   state :waiting, initial: true
  # end
end
