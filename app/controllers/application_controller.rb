class ApplicationController < ActionController::API
  #protect_from_forgery with: :null_session

  include DeviseTokenAuth::Concerns::SetUserByToken

  respond_to :json

  def confirmable_enabled?
    false
  end

  def access_token
    request.headers['HTTP_CLIENT_ID'] if user_signed_in?
  end
end
