# frozen_string_literal: true

module ChatService
  class Replier < ApplicationService
    def initialize(content)
      @content = content
    end

    def call
      nearest_address.content

      # take this content and publish to chat with a system prompt
      # enhance openAI responde with address.link like for more..
    end

    private

    def nearest_address
      Address.nearest_neighbors(
        :embedding,
        OpenaiService::Embedder.call(@content),
        distance: 'euclidean'
      ).first
    end
  end
end
