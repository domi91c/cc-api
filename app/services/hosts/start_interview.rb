module Hosts
  class StartInterview
    prepend Service

    def initialize(params)
      @request_id = params[:id]
      @stream_id = params[:stream_id]
    end

    def call
      # if @request.guest == current_user
      #   errors.add(:base, "Guest cannot be host of stream.")
      # end
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
