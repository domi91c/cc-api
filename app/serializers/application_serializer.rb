class ApplicationSerializer < ActiveModel::Serializer
  def json_member
    res = yield object
    if res.present?
      ActiveModelSerializers::SerializableResource.new(res)
    else
      {}
    end
  end
end

