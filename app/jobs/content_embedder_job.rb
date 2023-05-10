class ContentEmbedderJob < ApplicationJob
  queue_as :default

  def perform(address_id)
    AddressService::Embedder.call(address_id)
  end
end
