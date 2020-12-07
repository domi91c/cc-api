require 'rails_helper.rb'

RSpec.describe Stream, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  def login
    current_user = FactoryBot.create(:user, confirmed_at: Date.today)
    post user_session_path, params:  { email: current_user.email, password: 'password' }.to_json
  end

  it 'should be a spec' do
    assert true, true
  end
end
