class EmbedderJob < ApplicationJob
  queue_as :default

  def perform(embedding_id)
    EmbeddingService::Embed.call(embedding_id)
  end
end
