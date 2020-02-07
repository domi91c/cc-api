module Hosts
  class EndInterview
    prepend Service

    def initialize(params)
      @stream_id = params[:id]
      @request_id = params[:request_id]
    end

    def call
      @request.update(status: 'finished')
      @request.calls.set_end_time
      @request
    end

    private

      def stream
        Stream.find_by(content_identifier = @stream_id)
      end

      def request
        stream.requests.find(@request_id)
      end
  end
end
