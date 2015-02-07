require 'rails_helper'

RSpec.describe Result, type: :model do
  it 'has a valid factory' do
    result = FactoryGirl.build_stubbed(:result)
    expect(result).to be_valid
  end

  it 'is invalid if there is no game' do
    result = FactoryGirl.build_stubbed(:result, game: nil)
    expect(result).to be_invalid
  end

  it 'is invalid if there is no ticket' do
    result = FactoryGirl.build_stubbed(:result, ticket: nil)
    expect(result).to be_invalid
  end

  it 'is invalid if the amount is negative or missing' do
    result = FactoryGirl.build_stubbed(:result, amount: -2.00)
    expect(result).to be_invalid
    result.amount = nil
    expect(result).to be_invalid
  end
end
