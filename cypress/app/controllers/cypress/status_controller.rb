module Cypress
  class StatusController < ActionController::API

    def status
      render json: {"status": "Cypress OK"}
    end
  end
end
