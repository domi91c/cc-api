require 'rails_helper'

describe "streams", type: :request do

  describe "host can create a stream", type: :request do

    it "returns status code 200" do
      user = FactoryBot.create(:user, confirmed_at: Date.today)
      auth_post user, host_streams_path, params: { stream: {content_identifier: '0987654321'} }
      response_body = JSON.parse(response.body)

      expect(response_body["errors"]).to be(nil)
      expect(response.status).to eql(200)
    end
  end

end

