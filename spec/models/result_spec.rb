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

  it 'calculates the prize amount' do
    game = FactoryGirl.build_stubbed(:game, numbers: (1..20).to_a, bonus: 1)
    ticket = FactoryGirl.build_stubbed(:ticket, bet_amount: 2, games: [game], numbers: [1, 3, 4, 21])
    result = FactoryGirl.build_stubbed(:result, game: game, ticket: ticket)
    # ticket with 3/4 numbers matched, bet_amount of 2, and no bonus
    # 3/4 pays 4 times the bet_amount 2 to equal 8
    expect(result.prize_amount).to eql(8)
  end

  it 'calculates the prize amount with bonus' do
    game = FactoryGirl.build_stubbed(:game, numbers: (1..20).to_a, bonus: 5)
    ticket = FactoryGirl.build_stubbed(:ticket, bet_amount: 2, games: [game], numbers: [1, 3, 4, 21])
    result = FactoryGirl.build_stubbed(:result, game: game, ticket: ticket)
    # ticket with 3/4 numbers matched, bet_amount of 2, and no bonus
    # 3/4 pays 4 times the bet_amount 2 to equal 8 * 5 to equal 40
    expect(result.prize_amount_with_bonus).to eql(40)
  end
end
