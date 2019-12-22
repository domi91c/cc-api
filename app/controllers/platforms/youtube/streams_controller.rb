module Platforms
  module Youtube
    class StreamsController < ApplicationController
      before_action :authenticate_user!

      def index
        livestreams = ::Youtube::Livestreams.new(access_token, current_user.refresh_token)
        response = livestreams.scheduled
        render json: response
      end
    end
  end
end
