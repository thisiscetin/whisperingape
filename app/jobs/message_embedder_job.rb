class MessageEmbedderJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)
    message.update(embedding: OpenaiService::Embedder.call(message.content))
  end
end
