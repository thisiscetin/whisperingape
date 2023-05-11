class ContentFetcherJob < ApplicationJob
  queue_as :default

  def perform(address_id)
    AddressService::Fetcher.call(address_id)
  end
end
