module Host
  class StreamsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_stream, only: %i[show update]

    def index
      render json: current_user.streams
    end

    def show
      render json: @stream,
             serializer: Host::StreamSerializer,
             include: %w[casts requests requests.guest]
    end

    def create
      command = Hosts::ConnectStream.call(stream_params)
      stream = command.result

      if command.success?
        render json: stream, status: :created
      else
        render json: stream.errors, status: :unprocessable_entity
      end
    end

    def update
      case params[:trigger]
      when 'start'
        @stream.casts.create
      end
      render json: @stream, include: %w[casts requests requests.guest]
    end

    def set_stream
      @stream = current_user.streams.find_by(content_identifier: params[:id])
    end

    def stream_params
      params.require(:stream).permit(:content_identifier).merge(
        host_id: current_user.id
      )
    end
  end
end
