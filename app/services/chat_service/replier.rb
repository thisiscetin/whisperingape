# frozen_string_literal: true

module ChatService
  class Replier < ApplicationService
    def initialize(content)
      @content = content
      @nearest_content = nearest_content
    end

    def call
      OpenaiService::Chat.call([system_prompt, user_prompt])['choices'][0]['message']['content']
    end

    private

    def system_prompt
      m = <<HEREDOC
      Act as a chatbot of a company.
      According to the company content given inside tripple exclamation marks
      answer users question given inside tripple commas. !!!#{@nearest_content}!!!
HEREDOC
      ChatService::Message.new('system', m)
    end

    def user_prompt
      ChatService::Message.new('user', ",,,#{@content},,,")
    end

    def nearest_content
      Address.nearest_neighbors(
        :embedding,
        OpenaiService::Embedder.call(@content),
        distance: 'euclidean'
      ).first(3)
             .pluck(:content)
             .join(' ')
             .split
             .first(3000)
             .join(' ')
    end
  end
end
