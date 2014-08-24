class Image < ActiveRecord::Base
  has_attached_file :data, :styles => { :small => "100x100#", :medium => "300x300#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :data, :content_type => /\Aimage\/.*\Z/
  belongs_to :advert


  def self.destroy_images_a_without_advert_id
    Image.where(advert_id: nil).delete_all
  end
end
