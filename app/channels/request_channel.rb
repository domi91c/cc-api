class RequestChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'request_channel'
  end

  def unsubscribed;
  end
end
