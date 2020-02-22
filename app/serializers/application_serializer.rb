class ApplicationSerializer < ActiveModel::Serializer
  def json_member
    res = yield object
    res.present? ? ActiveModelSerializers::SerializableResource.new(res) : {}
  end
end
