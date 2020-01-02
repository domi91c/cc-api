class Thumbnail < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
