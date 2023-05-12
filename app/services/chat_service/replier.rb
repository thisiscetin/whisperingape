# frozen_string_literal: true

module ChatService
  class Replier < ApplicationService
    def initialize(content)
      @content = content
      @nearest_neighbors = nearest_neighbors
      @host = nearest_neighbors.first.ape.host
    end

    def call
      response = OpenaiService::Chat.call([system_prompt, user_prompt])['choices'][0]['message']['content']
      response + "\n Sources: #{@nearest_neighbors.pluck(:destination).join(' | ')}"
    end

    private

    def system_prompt
      m = <<HEREDOC
      Act as a personal assistant of #{@host}. Your task is to answer the questions related to #{@host} only.
      Refuse answering questions outside the content provided in this message.
      If you can't find the answer in this provided content, just say,
      "Hmm, I'm not sure about this yet, but I'm learning. You can contact customer support for faster assistance"
      Don't try to make up an answer.
      The content extracted from website #{@host} is below
      #{@nearest_content}
HEREDOC
      ChatService::Message.new('system', m)
    end

    def user_prompt
      ChatService::Message.new('user', @content)
    end

    def nearest_neighbors
      Address.nearest_neighbors(
        :embedding,
        OpenaiService::Embedder.call(@content),
        distance: 'euclidean'
      ).first(3)
    end

    def nearest_content
      @nearest_neighbors
        .pluck(:content)
        .join(' ')
        .split
        .first(3000)
        .join(' ')
    end
  end
end
