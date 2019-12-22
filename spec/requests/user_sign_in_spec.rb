require 'rails_helper'

describe "authentication", type: :request do

  describe "user can sign up", type: :request do
    it 'returns status code 200' do
      post user_registration_path, params: {email: "dominic.n@me.com", password: "foobar123"}
      response_body = JSON.parse(response.body)

      expect(response_body['errors']).to be(nil)
      expect(response.status).to eql(200)
    end
  end

  describe 'user can sign in' do
    it 'returns status code 200' do
      user = FactoryBot.create(:user)
      post user_session_path, params: {email: user.email, password: user.password}
      response_body = JSON.parse(response.body)

      expect(response_body['errors']).to be(nil)
      expect(response.status).to eql(200)
    end
  end

end

