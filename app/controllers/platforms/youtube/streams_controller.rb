module Platforms
  module Youtube
    class StreamsController < ApplicationController
      before_action :authenticate_user!

      def index
        streams = ::Youtube::Streams.new(access_token, current_user)
        response = streams.scheduled(refresh: params[:force_refresh])

        used_ids = current_user.streams.pluck(:content_identifier)
        

        render json: response, serializer: ::Youtube::ScheduledStreamsSerializer
      end

    end
  end
end
