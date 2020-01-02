require 'google/api_client/client_secrets.rb'
require 'google/apis/core/base_service'
require 'google/apis/youtube_v3'

module Youtube
  class Streams < ApplicationService
    def initialize(access_token, user)
      @user = user
      auth =
        Google::APIClient::ClientSecrets.new(
          {
            'web' => {
              'access_token' => access_token,
              'refresh_token' => user.refresh_token,
              'client_id' => ENV['GOOGLE_CLIENT_ID'],
              'client_secret' => ENV['GOOGLE_CLIENT_SECRET']
            }
          }
        )

      yt = Google::Apis::YoutubeV3
      @service = yt::YouTubeService.new
      @service.authorization = auth.to_authorization
    end

    def scheduled(refresh = false)
      if !refresh && (api_response = @user.api_responses.where(api: :youtube, kind: :streams_scheduled).last)
        return api_response
      else
        response = @service.list_live_broadcasts('id,snippet', broadcast_status: 'upcoming', max_results: 5)
        @user.api_responses.create(api: :youtube, response: response.as_json, kind: :streams_scheduled)
      end
    end

    def last
      live_stream = @service.list_live_broadcasts('id,snippet', broadcast_status: 'active', max_results: 1).items[0]
      channel = @service.list_channels('snippet,contentDetails,statistics', id: live_stream.snippet.channel_id, max_results: 1).items[0]

      {
        id: 1,
        title: live_stream.snippet.title,
        host_name: channel.snippet.title,
        video_id: live_stream.id
      }
    end

    def random
      # response = @service.list_searches('id, snippet', type: 'video', event_type: 'live', max_results: 1).items[0]
      response = OpenStruct.new(
        id: OpenStruct.new(
          video_id: '122'
        ),
        snippet:
          OpenStruct.new(
            title: 'This is an example of a stream title from YT',
            channel_title: 'A Random Channel',
          )
      )

      {
        id: 1,
        title: response.snippet.title,
        host_name: response.snippet.channel_title,
        video_id: response.id.video_id
      }
    end
  end
end
