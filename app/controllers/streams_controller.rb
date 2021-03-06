class StreamsController < ApplicationController
  before_action :set_stream, only: [:show]

  def index
    render json: Stream.all
  end

  def show
    render json: @stream, scope: current_user
  end

  private

  def set_stream
    @stream = Stream.find_by(content_identifier: params[:id])
  end
end
