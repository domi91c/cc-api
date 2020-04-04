require 'google/api_client/client_secrets.rb'
require 'google/apis/core/base_service'
require 'google/apis/youtube_v3'

module Youtube
  class Streams
    prepend Service

    def initialize(access_token:, user:, refresh: false)
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


      :redirect_uri => 'http://www.example.com/oauth2callback'
      yt = Google::Apis::YoutubeV3
      @service = yt::YouTubeService.new
      @service.authorization = auth.to_authorization
      auth.update!(
        redirect_uri: 'cuecast-api.herokuapp.com'
      )
      @refresh = refresh
    end

    def call
      if !@refresh && (api_response = @user.api_responses.where(api: :youtube, kind: :streams_scheduled).last)
        return api_response
      else
        response = @service.list_live_broadcasts('id,snippet', broadcast_status: 'upcoming', max_results: 5)
        @user.api_responses.create(api: :youtube, response: response.as_json, kind: :streams_scheduled)
      end
    end
  end
end
