module Hosts
  class ConnectStream
    prepend Service

    def initialize(params)
      @params = params
    end

    def call
      current_user = User.find(@params[:host_id])
      resp = current_user.api_responses.where(kind: 'streams_scheduled').order(:created_at).last
      snippet = resp.response['items'].find { |i| i['id'] == @params[:content_identifier] }['snippet']
      thumbnails = parse_thumbnails snippet

      current_user.streams.new(
        content_identifier: @params[:content_identifier],
        content_provider: 'youtube',
        title: snippet['title'],
        scheduled_time: snippet['scheduled_start_time'],
        thumbnails_attributes: thumbnails
      )
    end

    def parse_thumbnails(snippet)
      %w(default standard medium high).each_with_object([]) do |size, arr|
        if (tn = snippet['thumbnails'][size])
          obj = tn.clone
          obj['size'] = size
          arr << obj
        end
      end
    end
  end
end
