class ImagesController < ApplicationController
  def compress
    @image = Image.new(image_params)

    if @image.save
      ImageCompressionWorker.perform_async(@image.id)
      render json: @image, status: :created
    else
      render json: { image: @image.errors }, status: :unprocessable_entity
    end
  end

  def download
    @image = Image.find_by_uuid(params[:uuid])
    render json: @image
  end

  private

  def image_params
    params.require(:image).permit(:email, :image_file)
  end
end
