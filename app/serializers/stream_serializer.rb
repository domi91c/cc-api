class StreamSerializer < ApplicationSerializer
  attributes :id, :title, :host, :content_identifier, :scheduled_time, :thumbnail, :request

  def request
    if scope && request = object.requests.find_by(guest: scope)
      RequestSerializer.new(request).as_json(include: 'guest')
    elsif (request_id = instance_options[:request_id])
      RequestSerializer.new(
        object.requests.find(request_id)
      ).as_json(include: 'guest')
    else
      {}
    end
  end
end
