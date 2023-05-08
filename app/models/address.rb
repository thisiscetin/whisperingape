# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :ape, dependent: :destroy

  validates :destination, :visited, :processing, presence: true
  validates :destination, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
end
