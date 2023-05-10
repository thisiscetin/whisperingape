# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    association :ape

    destination { 'https://www.nationalgeographic.com/content.html' }
    active { true }
  end

  factory :address_deactivated, parent: :address do
    active { false }
  end

  factory :address_processed, parent: :address do
    content { 'some dummy content' }
    md5sum { '5cdb221ab5436a0cd7942840e48ef03d' }
    embedding { (0...1536).map { |x| x } }
  end
end
