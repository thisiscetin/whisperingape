# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ape do
  let(:ape) { build(:ape) }

  it 'is valid as a factory' do
    expect(ape).to be_valid
  end

  it 'is not valid when host is nil' do
    ape.host = nil
    expect(ape).not_to be_valid
  end

  it 'is not valid when host is empty' do
    ape.host = ''
    expect(ape).not_to be_valid
  end

  it 'is not valid when host is dummy' do
    ape.host = 'dummy'
    expect(ape).not_to be_valid
  end

  it 'is not valid when refresh in ours is zero' do
    ape.refresh_in_hours = 0
    expect(ape).not_to be_valid
  end

  it 'is not valid when refresh in ours is negative' do
    ape.refresh_in_hours = -1
    expect(ape).not_to be_valid
  end

  it 'is not valid when follow up is nil' do
    ape.follow_up = nil
    expect(ape).not_to be_valid
  end

  it 'is not valid when active is nil' do
    ape.active = nil
    expect(ape).not_to be_valid
  end
end
