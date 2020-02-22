class CallSerializer < ApplicationSerializer
  attributes :id, :request, :start_time, :from, :to, :type, :sdp, :candidate

  has_one :stream, serializer: StreamSerializer
  has_one :host, serializer: UserSerializer
  has_one :guest, serializer: UserSerializer

  def from
    instance_options[:from]
  end

  def to
    instance_options[:to]
  end

  def type
    instance_options[:type]
  end

  def sdp
    instance_options[:sdp]
  end

  def candidate
    instance_options[:candidate]
  end
end
