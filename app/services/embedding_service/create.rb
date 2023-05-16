# frozen_string_literal: true

module EmbeddingService
  class Create < ApplicationService
    def initialize(scrape_id)
      @scrape = Scrape.includes(:link).find(scrape_id)
    end

    def call
      validate_scrape

      Embedding.create!(
        {
          scrape_id: @scrape.id,
          destination: @scrape.link.destination,
          md5sum_gpt_content:,
          active: @scrape.gpt_content.split.count > 50
        }
      )
    end

    private

    def validate_scrape
      return if @scrape.gpt_content.present?

      raise StandardError, 'no gpt content for embedding present'
    end

    def md5sum_gpt_content
      Digest::MD5.hexdigest(@scrape.gpt_content)
    end
  end
end
