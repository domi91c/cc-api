class CastsController < ApplicationController
  before_action :authenticate_user!

  def show
    @stream = ::Youtube::Livestreams.new(access_token, current_user.refresh_token)
    response = @stream.list
    response.as_json
  end

  def mock_show
    @stream = ::Youtube::Livestreams.new(access_token, current_user.refresh_token)
    response = @stream.list
    render json: response
  end
end
