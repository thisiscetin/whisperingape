# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    association :ape

    destination { 'https://www.nationalgeographic.com/' }
    visited { false }
    processing { false }
  end

  factory :address_processing, parent: :address do
    processing { true }
  end

  factory :address_processed, parent: :address do
    visited { true }

    content { 'some dummy content' }
    md5sum { '5cdb221ab5436a0cd7942840e48ef03d' }

    # embeding will be attached in the service
  end
end
