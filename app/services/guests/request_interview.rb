module Guests
  class RequestInterview
    prepend Service

    def initialize(params)
      @stream = params[:stream]
      @guest = params[:guest]
    end

    def call
      if (request = @stream.requests.find_by(guest: @guest))
        if Request::INACTIVE_STATUSES.include? request.status
          unless request.update(status: :waiting)
            errors.add(:save_request, "Failed to update request.")
          end
        end
      else
        request = @stream.requests.new(guest: @guest)
        unless request.save
          errors.add(:base, "Failed to add request.")
        end
      end
      request
    end

    private

  end
end
