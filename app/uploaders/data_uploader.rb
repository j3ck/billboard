# encoding: utf-8

class DataUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :small do
    process resize_to_fill: [100, 100]
  end
    
  version :medium do
    process resize_to_fill: [200, 200]
  end
end
