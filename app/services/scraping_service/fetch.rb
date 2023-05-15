# frozen_string_literal: true

module ScrapingService
  class FetchResult
    attr_reader :scrape, :links

    def initialize(scrape, links)
      @scrape = scrape
      @links = links
    end
  end

  class Fetch < ApplicationService
    def initialize(link_id)
      @link = Link.includes(:ape).find(link_id)

      response = HTTParty.get(@link.destination)

      @doc = Nokogiri::HTML(response.body)
      @links = Nokogiri::HTML(response.body).css('a')
    end

    def call
      validate_content
      scrape = Scrape.create!({
                                content:,
                                md5sum:,
                                ape: @link.ape,
                                link: @link
                              })
      link_hrefs.each { |href| LinkService::Create.call(@link.ape.id, href) }

      FetchResult.new(scrape, link_hrefs)
    end

    private

    def md5sum
      Digest::MD5.hexdigest(content)
    end

    def validate_content
      return unless Scrape.find_by(md5sum:)

      raise StandardError, "md5 collusion for #{md5sum}"
    end

    def link_hrefs
      @links
        .map { |d| d.attribute('href').to_s }
        .map { |l| l.last == '/' ? l.chop : l }
        .filter { |l| l.include?(@link.ape.domain) }
        .split('#')
        .first
        .split('?')
        .first
        .uniq
    end

    def content
      cn = @doc
      cn.xpath('//style').remove
      cn.xpath('//script').remove
      cn.xpath('//img').remove
      cn.xpath('//svg').remove
      cn.xpath('//@*').remove
      cn.to_html
    end
  end
end
