# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :ape

  has_neighbors :embedding

  validates :destination, presence: true, uniqueness: true
  validates :destination, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validate :ape_host

  after_create :fetch_content
  after_save :embed_content

  def nearest
    nearest_neighbors(:embedding, distance: 'euclidean').first
  end

  private

  def ape_host
    return unless destination.present? && ape.present?
    return if destination.include?(ape.host)

    errors.add :destination, 'needs to be under ape host'
  end

  def fetch_content
    ContentFetcherJob.perform_later(id)
  end

  def embed_content
    # we only call OpenAI when there is a change in the content
    # so even if this is invoked mistakenly it won't be a problem
    ContentEmbedderJob.perform_later(id) if saved_changes[:md5sum] && content.present?
  end
end
