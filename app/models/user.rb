class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :api_responses, as: :owner
  has_many :streams, class_name: 'Stream', foreign_key: 'host_id'

end
