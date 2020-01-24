class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  has_many :api_responses, as: :owner
  has_many :streams, class_name: 'Stream', foreign_key: 'host_id'
  has_many :requests, class_name: 'Request', foreign_key: 'guest_id'
  has_one_attached :avatar

  def avatar_url
    # return '' unless avatar.attached?
    Rails.application.routes.url_helpers.url_for(avatar)
  end
end

