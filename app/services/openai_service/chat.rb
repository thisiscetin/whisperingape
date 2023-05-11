# frozen_string_literal: true

module OpenaiService
  class Chat < ApplicationService
    def initialize(messages)
      @messages = messages
      @openai_key = ENV.fetch('OPENAIKEY', '')
    end

    def call
      OpenAI::Client.new(access_token: @openai_key).chat(
        parameters: {
          model: 'gpt-3.5-turbo',
          messages: @messages,
          temperature: 0.7
        }
      )
    end
  end
end
