class GuestChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user

    active_requests = current_user.requests.active
    active_requests.update_all(interrupted: false)

    active_requests.each do |request|
      HostChannel.broadcast_to(request.stream.host,
        { action: 'requests#create', body: RequestSerializer.new(request).as_json(include: 'guest') }
      )
    end
  end

  def unsubscribed
    active_requests = current_user.requests.active
    active_requests.update_all(interrupted: true)

    active_requests.each do |request|
      HostChannel.broadcast_to(request.stream.host,
        { action: 'requests#destroy', body: RequestSerializer.new(request).as_json(include: 'guest') }
      )
    end
  end
end
