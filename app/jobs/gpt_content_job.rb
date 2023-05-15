class GptContentJob < ApplicationJob
  queue_as :default

  retry_on SocketError, wait: 10.minutes, attempts: 5
  retry_on NoMethodError, wait: 10.minutes, attempts: 5

  discard_on ActiveRecord::RecordNotFound

  def perform(scrape_id)
    ScrapingService::GptContent.call(scrape_id)
  end
end
