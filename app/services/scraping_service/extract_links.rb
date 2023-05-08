# frozen_string_literal: true

module ScrapingService
  class ExtractLinks < ApplicationService
    def initialize(url, base)
      @url = url
      @base = base

      @result = Set[]
    end

    def call
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      driver = Selenium::WebDriver.for(:chrome, options:)

      driver.navigate.to @url
      driver.find_elements(:tag_name, 'a').each { |elem| collect_if_matching(elem) }

      @result
    end

    private

    def collect_if_matching(elem)
      href = elem.attribute('href')
      return unless href.include?(@base)

      @result.add(href)
    end
  end
end
