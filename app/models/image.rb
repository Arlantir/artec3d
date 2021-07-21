class Image < ApplicationRecord
  mount_uploader :image_file, ImageFileUploader

  validates :email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
  validates :image_file, presence: true
end
