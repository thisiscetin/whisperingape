# frozen_string_literal: true

# remove visited, processing from address

module AddressService
  class Fetcher < ApplicationService
    def initialize(address_id)
      @address = Address.includes(:ape).find(address_id)
    end

    def call
      result = ScrapingService::Extract.call(@address.destination, @address.ape.host, 'body')

      @address.update(content: result.text, md5sum: Digest::MD5.hexdigest(result.text))
      create_adresses(@address.ape, result.links) if @address.ape.follow_up
    end

    private

    def create_adresses(ape, links)
      links.each do |link|
        AddressService::Creator.call(ape, link) unless Address.find_by(destination: link)
      end
    end
  end
end
