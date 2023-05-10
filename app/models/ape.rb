# frozen_string_literal: true

class Ape < ApplicationRecord
  has_many :addresses, dependent: :destroy

  validates :host, :refresh_in_hours, :follow_up, :active, presence: true
  validates :host, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :refresh_in_hours, comparison: { greater_than: 0 }
end
