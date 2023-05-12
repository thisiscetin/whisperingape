# frozen_string_literal: true

module AddressService
  class Fetcher < ApplicationService
    def initialize(address_id)
      @address = Address.includes(:ape).find(address_id)
    end

    # if md5ischanging and embedding is present, or embedding is empty - perform an embedding job as well
    def call
      result = ScrapingService::Extract.call(@address.destination, @address.ape.host, 'body')

      @address.update(content: result.text, md5sum: Digest::MD5.hexdigest(result.text))
      create_adresses(@address.ape, result.links) if @address.ape.follow_up
    end

    private

    def create_adresses(ape, links)
      cleaned_links = links
                      .map { |link| link.split('#').first }
                      .map { |link| link.split('?').first }
                      .map { |link| link.last == '/' ? link.chop : link }
                      .uniq

      cleaned_links.each do |link|
        AddressService::Creator.call(ape, link) unless Address.find_by(destination: link)
      end
    end
  end
end
