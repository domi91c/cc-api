class ThumbnailSerializer < ApplicationSerializer
  attributes :url, :height, :width

  def url
    object.image_url || ''
  end
end
