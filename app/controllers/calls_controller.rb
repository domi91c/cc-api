class CallsController < ApplicationController
  before_action :authenticate_user!

  def update
    if call.request.status == 'live'
      CallChannel.broadcast_to(
        recipient,
        CallSerializer.new(
          call,
          from: current_user.email,
          to: call_params[:to],
          type: call_params[:type],
          sdp: call_params[:sdp],
          candidate: call_params[:candidate],
          request_id: call.request_id,
          scope: current_user
        )
      )
    end
    head :no_content
  end

  private

  def call
    Call.find(params[:id])
  end

  def recipient
    call.host == current_user ? call.guest : call.host
  end

  def call_params
    params.permit(:type, :from, :to, :sdp, :candidate)
  end
end
