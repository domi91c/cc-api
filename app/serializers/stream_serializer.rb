class StreamSerializer < ApplicationSerializer
  attributes :id,
             :title,
             :host,
             :content_identifier,
             :scheduled_time,
             :thumbnail,
             :request

  def request
    if (request_id = instance_options[:request_id])
      RequestSerializer.new(object.requests.find(request_id)).as_json(
        include: 'guest'
      )
    elsif scope && (request = object.requests.find_by(guest: scope))
      RequestSerializer.new(request).as_json(include: 'guest')
    else
      {'ello': 32}
    end
  end
end
