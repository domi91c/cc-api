module Host
  module Streams
    class RequestsController < ApplicationController
      before_action :set_stream

      def update
        case params[:trigger]
        when 'accept'
          request = @stream.requests.find(params[:id])
          request.update(status: 'live')
          GuestChannel.broadcast_to(request.guest,
            { action: 'requests#update', body: ::StreamSerializer.new(@stream, request_id: request.id).as_json }
          )
        when 'reject'
          request = @stream.requests.find(params[:id])
          request.update(status: 'rejected')
          GuestChannel.broadcast_to(request.guest,
            { action: 'requests#update', body: ::StreamSerializer.new(@stream, request_id: request.id).as_json }
          )
        end
        render json: @stream.reload, serializer: Host::StreamSerializer, include: %w(requests requests.guest)
      end

      private

      def set_stream
        @stream = Stream.find_by(content_identifier: params[:stream_id])
      end
    end
  end
end
