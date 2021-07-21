require 'mini_magick'

class ImageCompressionService < ApplicationService
  def initialize(image)
    @image = Image.where(id: image).first
  end

  def call
    uuid = SecureRandom.uuid
    image = MiniMagick::Image.open(@image.image_file.current_path)

    original_img = image.signature
    image.quality(1)
    convert_img = image.signature

    if original_img != convert_img
      @image.update!(uuid: uuid)
      image.write(@image.image_file.current_path)
      ImageMailer.compress_img(@image).deliver_now
    else
      ImageMailer.not_compress_img(@image).deliver_now
    end
  end
end
