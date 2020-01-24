module Hosts
  class StartInterview
    prepend Service

    def initialize(params)
      @stream = Stream.find_by(content_identifier: params[:stream_id])
      @request = @stream.requests.find(params[:id])
    end

    def call
      @request.update(status: 'live')
      @request.create_call
      @request
    end

    private

  end
end
