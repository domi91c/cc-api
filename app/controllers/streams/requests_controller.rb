module Streams
  class RequestsController < ApplicationController
    before_action :set_stream

    def create
      request = @stream.requests.create(guest: current_user)
      ActionCable.server.broadcast('request_channel', RequestSerializer.new(request).as_json(include: 'guest'))
      head :no_content
    end

    private

    def set_stream
      @stream = Stream.find_by(content_identifier: params[:stream_id])
    end
  end
end
