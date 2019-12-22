class StreamsController < ApplicationController
  def show
    @stream =
      ::Youtube::Livestreams.new(access_token, current_user.refresh_token)
    binding.pry
    response = @stream.random
    render json: response.as_json
  end
end
