class RequestSerializer < ApplicationSerializer
  attributes :id, :status
  has_one :stream
  has_one :guest, serializer: UserSerializer
end
