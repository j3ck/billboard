require 'file_size_validator'
class Image < ActiveRecord::Base
  mount_uploader :data, DataUploader
  belongs_to :advert

  validates :data,
    file_size: {
    maximum: 2.0.megabytes.to_i
  }

  def self.destroy_images_a_without_advert_id
    Image.where(advert_id: nil).delete_all
  end
end
