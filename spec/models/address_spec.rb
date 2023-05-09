# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address do
  let(:address) { build(:address) }
  let(:address_processing) { build(:address_processing) }
  let(:address_processed) { build(:address_processed) }
  let(:first_vector) { (0...1536).map { |x| x } }
  let(:second_vector) { (0...1536).map { |x| x + 1 } }

  it 'is valid a factory' do
    expect([address, address_processing, address_processed]).to all be_valid
  end

  it 'is not valid without an ape' do
    address.ape = nil
    expect(address).not_to be_valid
  end

  it 'is not valid with empty destination' do
    address.destination = ''
    expect(address).not_to be_valid
  end

  it 'is not valid with nil destination' do
    address.destination = nil
    expect(address).not_to be_valid
  end

  it 'is not valid with a dumy destination' do
    address.destination = 'dummy'
    expect(address).not_to be_valid
  end

  it 'is not valid when there is a record with same destination' do
    address.save
    a2 = build(:address)
    expect(a2).not_to be_valid
  end

  it 'returns nil to nearest when there is no record' do
    expect(address.nearest).to be_nil
  end

  it 'returns any record as nearest with same size embedding when present' do
    address.embedding = first_vector
    address.save
    a2 = build(:address, embedding: second_vector)
    expect(a2.nearest).to eq(address)
  end

  it 'returns closer record as nearest with same size embedding when multiple ones present' do
    address.embedding = second_vector
    address.save
    create(:address, destination: 'https://xyz.com', embedding: first_vector)

    expect(build(:address, embedding: second_vector).nearest).to eq(address)
  end
end
