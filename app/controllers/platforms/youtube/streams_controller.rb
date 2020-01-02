module Platforms
  module Youtube
    class StreamsController < ApplicationController
      before_action :authenticate_user!

      def index
        streams = ::Youtube::Streams.new(access_token, current_user)
        response = streams.scheduled(params[:force_refresh])
        render json: response, serializer: ::Youtube::ScheduledStreamsSerializer
      end

    end
  end
end
