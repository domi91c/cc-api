module Streams
  class RequestsController < ApplicationController
    before_action :set_stream

    def create
      request = @stream.requests.new(guest: current_user)
      if request.save
        HostChannel.broadcast_to(@stream.host,
          { action: 'requests#create', body: RequestSerializer.new(request).as_json(include: 'guest') }
        )
        render json: @stream
      else
        render json: @stream
      end
    end

    def destroy
      request = @stream.requests.find(params[:id])
      request.update(status: :cancelled)
      if request.destroy
        HostChannel.broadcast_to(@stream.host,
          { action: 'requests#destroy', body: RequestSerializer.new(request).as_json(include: 'guest') }
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
