# frozen_string_literal: true

module LinkService
  class Create < ApplicationService
    def initialize(ape_id, address)
      @ape_id = ape_id
      @address = address
    end

    def call
      return if Link.find_by(destination: @address)

      Link.create!(
        {
          ape_id: @ape_id,
          destination: @address
        }
      )
    end
  end
end
