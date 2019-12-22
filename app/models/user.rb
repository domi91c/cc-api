class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :streams
end
