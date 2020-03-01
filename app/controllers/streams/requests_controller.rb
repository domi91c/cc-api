module Streams
  class RequestsController < ApplicationController
    before_action :set_stream

    def create
      command =
        Guests::RequestInterview.call(stream: @stream, guest: current_user)

      if command.success?
        request = command.result
        HostChannel.broadcast_to(
          @stream.host,
          {
            action: 'requests#create',
            body: RequestSerializer.new(request).as_json(include: 'guest')
          }
        )
        render json: @stream
      else
        render json: @stream
      end
    end

    def update
      request = @stream.requests.find(params[:id])
      request.update(status: 'live')
      HostChannel.broadcast_to(
        @stream.host,
        {
          action: 'requests#create',
          body: RequestSerializer.new(request).as_json(include: 'guest')
        }
      )

      render json: @stream
    end

    def destroy
      request = @stream.requests.find(params[:id])
      request.status = :cancelled
      if request.save
        HostChannel.broadcast_to(
          @stream.host,
          {
            action: 'requests#destroy',
            body: RequestSerializer.new(request).as_json(include: 'guest')
          }
        )
        render json: @stream
      else
        render json: @stream
      end
    end

    private

    def set_stream
      @stream = Stream.find_by(content_identifier: params[:stream_id])
    end
  end
end
