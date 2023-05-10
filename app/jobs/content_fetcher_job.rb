class ContentFetcherJob < ApplicationJob
  queue_as :default

  # retry_on x
  # discard_on y

  def perform(address_id)
    AddressService::Fetcher.call(address_id)
  end
end
