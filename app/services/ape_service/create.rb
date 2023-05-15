# frozen_string_literal: true

module ApeService
  class Creator < ApplicationService
    def initialize(domain, discovery)
      @domain = domain
      @discovery = discovery
    end

    def call
      Ape.create!(
        {
          domain: @domain,
          discovery: @discovery,
          subdomain_followup: false
        }
      )
    end
  end
end
