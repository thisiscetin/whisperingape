# frozen_string_literal: true

module ScrapingService
  class ScrapingResult
    attr_reader :links, :content

    def initialize(links, content)
      @links = links
      @content = content
    end

    def md5sum
      Digest::MD5.hexdigest @content
    end
  end

    class Extractv2 < ApplicationService
        def initialize(url)
            response = HTTParty.get(url)
            
            @doc = Nokogiri::HTML(response.body)
        end

        def call
          ScrapingResult.new(
            all_links,
            content
          )
        end

        private

        def all_links
          links = @doc.css('a')
          links
            .map { |d| d.attribute('href').to_s }
            .uniq
        end

        def content
          @doc.xpath('//style').remove
          @doc.xpath('//script').remove
          @doc.xpath('//img').remove
          @doc.xpath('//svg').remove
          @doc.xpath('//@*').remove

          @doc.to_html
        end
    end
end