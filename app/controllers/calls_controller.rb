class CallsController < ApplicationController
  before_action :authenticate_user!

  def create
    head :no_content
    ActionCable.server.broadcast("call_channel", call_params)
  end

  def index
    render json: current_user
  end

  private

  def call_params
    params.permit(:call, :type, :from, :to, :sdp)
  end
end
