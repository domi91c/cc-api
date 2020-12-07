module Cypress
  class TestController < ActionController::API
    def create
      binding.pry
      render json: {"status": "Cypress OK"}
    end
  end
end
