class CallSerializer < ApplicationSerializer
  attributes :id, :from, :type, :sdp
  # belongs_to :request
  has_one :stream, serializer: StreamSerializer
  has_one :host, serializer: UserSerializer
  has_one :guest, serializer: UserSerializer

  def from
    instance_options[:from]
  end

  def type
    instance_options[:type]
  end

  def sdp
    instance_options[:sdp]
  end

end

