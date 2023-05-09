# frozen_string_literal: true

module AddressService
  class Creator < ApplicationService
    def initialize(ape, destination)
      @ape = ape
      @destination = destination
    end

    def call
      Address.create!(
        {
          ape: @ape,
          destination: @destination,
          visited: false,
          processing: false
        }
      )
    end
  end
end
