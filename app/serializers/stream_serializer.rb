class StreamSerializer < ApplicationSerializer
  attributes :id, :title, :content_identifier, :scheduled_time, :thumbnail

  def thumbnail
    json_member { |o| o.thumbnails.find_by_size('default') }
  end
end

