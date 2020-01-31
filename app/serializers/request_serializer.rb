class RequestSerializer < ApplicationSerializer
  attributes :id, :status, :call
  has_one :stream
  has_one :guest, serializer: UserSerializer

  def call
    if object.calls.last
      CallSerializer.new(object.calls.last)
    end
  end
end

