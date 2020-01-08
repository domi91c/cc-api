class Youtube::ScheduledStreamsSerializer < ApplicationSerializer
  attributes :id, :items

  def items
    object.response['items'].map do |item|
      {
        id: item['id'],
        title: item['snippet']['title'],
        description: item['snippet']['description'],
        scheduled_start_time: item['snippet']['scheduled_start_time'],
        thumbnails: item['snippet']['thumbnails']
      }
    end
  end

end
