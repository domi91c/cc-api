class StreamSerializer < ApplicationSerializer
  attributes :id, :title, :content_identifier, :scheduled_time, :thumbnail, :request

  def thumbnail
    json_member { |o| o.thumbnails.find_by_size('default') }
  end

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
