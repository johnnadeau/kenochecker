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

  it 'calculates the total prize amount' do
    game = FactoryGirl.build_stubbed(:game, numbers: (1..20).to_a, 
                                     game_number: 123, bonus: 1)
    game_1 = FactoryGirl.build_stubbed(:game, numbers: (5..25).to_a,
                                       game_number: 124, bonus: 1)
    ticket = FactoryGirl.build_stubbed(:ticket, bet_amount: 1, bonus: false,
                                       numbers: [1, 2, 5, 23], games: [game, game_1])
    result = FactoryGirl.build_stubbed(:result, ticket: ticket, game: game)
    result_1 = FactoryGirl.build_stubbed(:result, ticket: ticket, game: game_1)
    # game 0 has 3/4 matched numbers for 4
    # game 1 has 2/4 matched numbers for 1
    expect(ticket.total_prize_amount).to eql(5)
  end

  it 'calculates the total prize amount with bonus' do
    game = FactoryGirl.build_stubbed(:game, numbers: (1..20).to_a, 
                                     game_number: 123, bonus: 10)
    game_1 = FactoryGirl.build_stubbed(:game, numbers: (5..25).to_a,
                                       game_number: 124, bonus: 1)
    ticket = FactoryGirl.build_stubbed(:ticket, bet_amount: 1, bonus: true,
                                       numbers: [1, 2, 5, 23], games: [game, game_1])
    result = FactoryGirl.build_stubbed(:result, ticket: ticket, game: game)
    result_1 = FactoryGirl.build_stubbed(:result, ticket: ticket, game: game_1)
    # game 0 has 3/4 matched numbers for 4 * 10 bonus for 40
    # game 1 has 2/4 matched numbers for 1
    expect(ticket.total_prize_amount).to eql(41)
  end
end
