module Host
  module Streams
    class RequestsController < ApplicationController
      before_action :set_stream

      def update
        case params[:trigger]
        when 'accept'
          start_interview = Hosts::StartInterview.call(params.merge(current_user: current_user))
          request = start_interview.result

          if start_interview.success?
            GuestChannel.broadcast_to(request.guest,
              { action: 'requests#update', body: ::StreamSerializer.new(request.stream, request_id: request.id).as_json }
            )
          end
        when 'finish'
          request = @stream.requests.find(params[:id])
          request.update(status: 'finished')
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
