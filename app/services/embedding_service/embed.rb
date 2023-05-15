# frozen_string_literal: true

module EmbeddingService
  class Embed < ApplicationService
    def initialize(embedding_id)
      @embedding = Embedding.includes(:scrape).find(embedding_id)

      @content = @embedding.scrape.gpt_content
    end

    def call
      @embedding.update(
        v: OpenaiService::Embedder.call(@content)
      )
    end
  end
end
