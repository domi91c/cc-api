module Host
  class StreamSerializer < ApplicationSerializer
    attributes :id, :title, :content_identifier, :scheduled_time, :thumbnail

    has_many :requests do
      object.requests.active
    end

    def thumbnail
      json_member { |o| o.thumbnails.find_by_size('default') }
    end
  end
end
