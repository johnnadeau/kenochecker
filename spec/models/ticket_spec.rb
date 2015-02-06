require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it 'has a valid factory' do
    ticket = FactoryGirl.build_stubbed(:ticket)
    expect(ticket).to be_valid
  end

  it 'is invalid without 1..12 numbers' do
    # no numbers (nil)
    ticket = FactoryGirl.build_stubbed(:ticket, numbers: nil)
    expect(ticket).to be_invalid
    # no numbers (0)
    ticket.numbers = []
    expect(ticket).to be_invalid
    # too many numbers
    ticket.numbers = (1..13).to_a
    expect(ticket).to be_invalid
  end

  it 'is invalid without a valid bet amount(1, 2, 5, 10, 20)' do
    ticket = FactoryGirl.build_stubbed(:ticket, bet_amount: 7)
    expect(ticket).to be_invalid
  end

  it 'is invalid if any number is outside the number range(1..80)' do
    ticket = FactoryGirl.build_stubbed(:ticket)
    ticket.numbers[0] = -1
    expect(ticket).to be_invalid
    ticket.numbers[0] = 81
    expect(ticket).to be_invalid
  end

  it 'is invalid if any number is not unique' do
    ticket = FactoryGirl.build_stubbed(:ticket)
    ticket.numbers[0] = ticket.numbers[1] = 1
    expect(ticket).to be_invalid
  end
end
