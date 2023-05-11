class AddressEmbedderJob < ApplicationJob
  queue_as :default

  def perform(address_id)
    address = Address.find(address_id)
    address.update(embedding: OpenaiService::Embedder.call(address.content))
  end
end
