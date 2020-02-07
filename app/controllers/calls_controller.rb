class CallsController < ApplicationController
  before_action :authenticate_user!

  def create
    head :no_content
    CallChannel.broadcast_to(recipient,
      CallSerializer.new(
        call,
        from: current_user.email,
        type: call_params[:type],
        sdp: call_params[:sdp]
      )
    )
  end

  private

    def call
      Call.find(params[:id])
    end

    def recipient
      if call.host == current_user
        call.guest
      else
        call.host
      end
    end

    def call_params
      params.permit(:id, :type, :from, :sdp)
    end
end
