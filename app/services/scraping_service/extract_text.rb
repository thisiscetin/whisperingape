# frozen_string_literal: true

module ScrapingService
  class ExtractText < ApplicationService
    def initialize(url, tag)
      @url = url
      @tag = tag
    end

    def call
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      driver = Selenium::WebDriver.for(:chrome, options:)

      driver.navigate.to @url
      driver.find_element(:tag_name, @tag).text
    end
  end
end
