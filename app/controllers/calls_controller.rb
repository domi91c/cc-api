class CallsController < ApplicationController
  before_action :authenticate_user!

  def create
    head :no_content
    CallChannel.broadcast_to(User.find_by(email: call_params[:to]), call_params)
  end

  private

  def call_params
    params.permit(:call, :type, :from, :to, :sdp)
  end
end
