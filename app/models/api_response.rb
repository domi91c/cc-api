class ApiResponse < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
