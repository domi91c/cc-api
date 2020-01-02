class Stream < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  has_many :thumbnails, as: :owner, dependent: :destroy

  accepts_nested_attributes_for :thumbnails
end
