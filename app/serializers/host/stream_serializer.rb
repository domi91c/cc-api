module Host
  class StreamSerializer < ApplicationSerializer
    attributes :id, :title, :content_identifier, :scheduled_time, :thumbnail

    has_many :casts
    has_many :requests

    def thumbnail
      json_member { |o| o.thumbnails.find_by_size('default') }
    end
  end
end
