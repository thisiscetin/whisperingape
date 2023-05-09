# frozen_string_literal: true

FactoryBot.define do
  factory :ape do
    host { 'https://www.nationalgeographic.com' }
    refresh_in_hours { 24 }
    follow_up { true }
    active { true }
  end
end
