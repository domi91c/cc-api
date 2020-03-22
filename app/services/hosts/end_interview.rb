module Hosts
  class EndInterview
    prepend Service

    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      request.update(status: 'finished')
      request.current_call.set_end_time
      request
    end

    private

      def request
        stream = Stream.find_by_content_identifier(params[:stream_id])
        stream.requests.find(params[:id])
      end
  end
end
