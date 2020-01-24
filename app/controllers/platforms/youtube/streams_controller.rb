module Platforms
  module Youtube
    class StreamsController < ApplicationController
      before_action :authenticate_user!

      def index
        command = ::Youtube::Streams.call(
          access_token: access_token,
          user: current_user,
          refresh: params[:force_refresh]
        )
        if command.success?
          scheduled_content = command.result
          # used_ids = current_user.streams.pluck(:content_identifier)
          render json: scheduled_content, serializer: ::Youtube::ScheduledStreamsSerializer
        end
      end

    end
  end
end
