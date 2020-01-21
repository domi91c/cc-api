module Streams
  class CreateRequest < ApplicationService
    def initialize(params)
      @stream = params[:stream]
      @guest = params[:guest]
    end

    def call
      if (request = @stream.requests.find_by(guest: @guest))
        if Request::INACTIVE_STATUSES.include? request.status
          request.status = :waiting
        end
      else
        request = @stream.requests.new(guest: @guest)
      end
      request
    end

    private

  end
end
