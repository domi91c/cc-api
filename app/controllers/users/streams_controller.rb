module Users
  class StreamsController < ApplicationController
    def index
      render json: current_user.streams
    end

    def update
      params[:trigger]
    end
  end
end
