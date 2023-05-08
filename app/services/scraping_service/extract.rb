# frozen_string_literal: true

module ScrapingService
  class ScrapingResult
    attr_reader :text, :links

    def initialize(text, links)
      @text = text
      @links = links
    end
  end

  class Extract < ApplicationService
    def initialize(url, base, tag)
      @url = url
      @base = base
      @tag = tag

      @links = Set[]
    end

    def call
      driver = selenium_driver
      driver.navigate.to @url
      driver.find_elements(:tag_name, 'a').each { |elem| collect_if_matching(elem) }

      ScrapingResult.new(
        driver.find_element(:tag_name, @tag).text,
        @links
      )
    end

    private

    def selenium_driver
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')

      Selenium::WebDriver.for(:chrome, options:)
    end

    def collect_if_matching(elem)
      href = elem.attribute('href')
      return unless href.include?(@base)

      @links.add(href)
    end
  end
end
