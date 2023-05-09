# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :ape

  has_neighbors :embedding

  validates :destination, presence: true, uniqueness: true
  validates :destination, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validate :ape_host

  def nearest
    nearest_neighbors(:embedding, distance: 'euclidean').first
  end

  private

  def ape_host
    return unless destination.present? && ape.present?
    return if destination.include?(ape.host)

    errors.add :destination, 'needs to be under ape host'
  end
end
