module Hosts
  class StartInterview
    prepend Service
    attr_reader :current_user

    def initialize(params)
      @current_user = params[:current_user]
      @request_id = params[:id]
      @stream_id = params[:stream_id]
    end

    def call
      errors.add(:base, "Guest cannot be host of stream.") if request.guest == current_user
      stream.requests.where(status: 'live').update_all(status: 'waiting')
      request.update(status: 'live')
      request.calls.create
      request
    end

    private

    def stream
      Stream.find_by(content_identifier: @stream_id)
    end

    def request
      @request = stream.requests.find(@request_id)
    end
  end
end
