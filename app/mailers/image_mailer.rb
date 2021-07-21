class ImageMailer < ApplicationMailer

  def compress_img(image)
    @uuid = image.uuid

    mail to: image.email, subject: "Сжатие изображения"
  end

  def not_compress_img(image)
    mail to: image.email, subject: "Сжатие изображения"
  end
end
