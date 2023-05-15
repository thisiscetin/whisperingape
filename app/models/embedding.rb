# frozen_string_literal: true

class Embedding < ApplicationRecord
  belongs_to :scrape

  validates :destination, :md5sum_gpt_content, presence: true
  validates :destination, uniqueness: true
  validates :md5sum_gpt_content, uniqueness: true

  after_create :embed_content

  private

  def embed_content
    EmbedderJob.perform_later(id)
  end
end
