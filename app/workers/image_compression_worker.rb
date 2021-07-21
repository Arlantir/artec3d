class ImageCompressionWorker
  include Sidekiq::Worker

  def perform(id)
    ImageCompressionService.call(id)
  end
end
