require 'carrierwave/processing/mini_magick'

class FeaturedImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  # Only commonly used image formats are allowed.
  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  # Storage directory
  def store_dir
    "#{Rails.env}/posts/#{model.id}/featured_images"
  end

  # A variety of file sizes are processed.
  version :thumb do
    process resize_to_fill: [200, 200]
  end

  version :small do
    process resize_to_fill: [512, 512]
  end

  version :medium do
    process resize_to_fill: [768, 768]
  end

  version :large do
    process resize_to_fill: [1024, 1024]
  end
end