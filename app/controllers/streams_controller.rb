class StreamsController < ApplicationController

  def index
    render json: Stream.all
  end

  def show
    @stream = Youtube::Streams.new(access_token, current_user.refresh_token)
    response = @stream.scheduled
    render json: response.as_json
  end

  def create
    stream = Streams::CreateStream.call(stream_params)
    if stream.save
      render json: stream, status: :created
    else
      binding.pry
      render json: stream.errors, status: :unprocessable_entity
    end
  end

  def stream_params
    params.require(:stream).permit(:content_identifier).merge(host_id: current_user.id)
  end
end
