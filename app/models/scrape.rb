# frozen_string_literal: true

class Scrape < ApplicationRecord
  belongs_to :ape
  belongs_to :link

  has_one :embedding, dependent: :destroy

  validates :content, :md5sum, presence: true
  validates :md5sum, uniqueness: true

  after_create :scrape_gpt_content

  after_save :trigger_embedding

  private

  def scrape_gpt_content
    GptContentJob.perform_later(id)
  end

  def trigger_embedding
    EmbeddingService::Create.call(id) if saved_changes[:gpt_content] && gpt_content.present?
  end
end
