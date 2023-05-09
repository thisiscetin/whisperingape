# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :ape, dependent: :destroy

  has_neighbors :embedding

  validates :destination, presence: true, uniqueness: true
  validates :destination, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])

  def nearest
    nearest_neighbors(:embedding, distance: 'euclidean').first
  end
end
