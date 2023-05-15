class ScraperJob < ApplicationJob
  queue_as :default

  retry_on SocketError, wait: 10.minutes, attempts: 5

  discard_on ActiveRecord::RecordInvalid
  discard_on StandardError

  def perform(link_id)
    ScrapingService::Fetch.call(link_id)
  end
end
