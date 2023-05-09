# frozen_string_literal: true

module ApeService
  class Creator < ApplicationService
    def initialize(host, refresh_in, follow_up)
      @host = host
      @refresh_in = refresh_in
      @follow_up = follow_up
    end

    def call
      Ape.create!(
        {
          host: @host,
          refresh_in_hours: @refresh_in,
          follow_up: @follow_up,
          active: true
        }
      )
    end
  end
end
