class Thumbnail < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_one_attached :image
  before_save :download_image

  def download_image
    return unless url
    self.image.attach(io: open(url), filename: "#{id}_#{size}.jpg")
  end

  def image_url
    Rails.application.routes.url_helpers.url_for(image)
  end
end
