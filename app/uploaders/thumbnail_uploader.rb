class ThumbnailUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  SIZE = 200

  process resize_to_fit: [SIZE, SIZE]
  storage :file

  def store_dir
    "thumbnails/"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def content_type_whitelist
    /image\//
  end

end
