# frozen_string_literal: true

class Ape < ApplicationRecord
  has_many :links, dependent: :destroy
  has_many :scrapes, dependent: :destroy

  validates :domain, uniqueness: true, presence: true
end
