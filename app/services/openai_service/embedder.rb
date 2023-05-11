# frozen_string_literal: true

module OpenaiService
  class Embedder < ApplicationService
    def initialize(content)
      @content = content
      @openai_key = ENV.fetch('OPENAIKEY', '')
    end

    def call
      OpenAI::Client.new(access_token: @openai_key).embeddings(
        parameters: {
          model: 'text-embedding-ada-002',
          input: @content
        }
      )['data'][0]['embedding']
    end
  end
end
