class ApplicationController < ActionController::API
  #protect_from_forgery with: :null_session
  include ActionController::Serialization
  include DeviseTokenAuth::Concerns::SetUserByToken

  serialization_scope :current_user

  respond_to :json

  def confirmable_enabled?
    false
  end

  def access_token
    request.headers['HTTP_CLIENT_ID'] if user_signed_in?
  end
end
