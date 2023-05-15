# frozen_string_literal: true

class Link < ApplicationRecord
  belongs_to :ape

  has_one :scrape, dependent: :destroy

  validates :destination, uniqueness: true, presence: true

  after_create :scrape_link

  private

  def scrape_link
    ScraperJob.perform_later(id)
  end
end
