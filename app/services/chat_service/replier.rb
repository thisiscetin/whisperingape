# frozen_string_literal: true

module ChatService
  class Replier < ApplicationService
    def initialize(content)
      @content = content
      @nearest_address = nearest_address
    end

    def call
      response = OpenaiService::Chat.call([system_prompt, user_prompt])['choices'][0]['message']['content']

      response + footer
    end

    private

    def footer
      "\n You may get more information about your question from: #{@nearest_address.destination}"
    end

    def system_prompt
      m = <<HEREDOC
      Act as a chatbot of Upcoach.
      According to the content given inside tripple exclamation marks
      answer users question given inside tripple commas. !!!#{@nearest_address.content}!!!
HEREDOC
      ChatService::Message.new('system', m)
    end

    def user_prompt
      ChatService::Message.new('user', ",,,#{@content},,,")
    end

    def nearest_address
      Address.nearest_neighbors(
        :embedding,
        OpenaiService::Embedder.call(@content),
        distance: 'euclidean'
      ).first
    end
  end
end
