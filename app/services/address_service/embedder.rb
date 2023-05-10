# frozen_string_literal: true

module AddressService
  class Embedder < ApplicationService
    def initialize(address_id)
      @address = Address.find(address_id)
      @openai_key = ENV.fetch('OPENAIKEY', '')
    end

    def call
      @address.update(embedding:)
    end

    private

    def embedding
      OpenAI::Client.new(access_token: @openai_key).embeddings(
        parameters: {
          model: 'text-embedding-ada-002',
          input: @address.content
        }
      )['data'][0]['embedding']
    end
  end
end
