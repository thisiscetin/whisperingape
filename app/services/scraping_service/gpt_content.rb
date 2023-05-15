# frozen_string_literal: true

module ScrapingService
  class GptContent < ApplicationService
    def initialize(scrape_id)
      @scrape = Scrape.find(scrape_id)
    end

    def call
      response = OpenaiService::Chat.call([system_prompt, user_prompt])
      gpt_content = response['choices'][0]['message']['content']

      @scrape.update(gpt_content:)
    end

    private

    def system_prompt
      m = <<HEREDOC
      Act as an HTML to text converter. Convert HTML to a format
      that is easily embeddable to a LLM such as text-embedding-ada-002 model of OpenAI.
HEREDOC
      OpenaiService::Message.new('system', m)
    end

    def user_prompt
      OpenaiService::Message.new('user', @scrape.content)
    end
  end
end
