require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'has a valid factory' do
    game = FactoryGirl.build_stubbed(:game)
    expect(game).to be_valid
  end

  it 'is invalid without exactly 20 numbers' do
    game = FactoryGirl.build_stubbed(:game)
    # too many numbers
    game.numbers << 21
    expect(game).to be_invalid
    # too few numbers
    game.numbers = game.numbers.take 10
    expect(game).to be_invalid
    # no numbers (nil)
    game.numbers = nil
    expect(game).to be_invalid
  end

  it 'is invalid if any number is outside the number range (1..80)' do
    game = FactoryGirl.build_stubbed(:game)
    game.numbers[0] = -1
    expect(game).to be_invalid
    game.numbers[0] = 81
    expect(game).to be_invalid
  end

  it 'is invalid if any number is duplicated' do
    game = FactoryGirl.build_stubbed(:game)
    game.numbers[0] = game.numbers[1] = 1
    expect(game).to be_invalid
  end

  it 'is invalid without a game_date' do
    game = FactoryGirl.build_stubbed(:game, game_date: nil)
    expect(game).to be_invalid
  end

  it 'is invalid without a game_number' do
    game = FactoryGirl.build_stubbed(:game, game_number: nil)
    expect(game).to be_invalid
  end

  it 'is invalid without a valid bonus multiplier (1, 3, 4, 5, 10)' do
    game = FactoryGirl.build_stubbed(:game, bonus: 2)
    expect(game).to be_invalid
  end

  describe 'find by game number' do
    it 'from the database' do
      FactoryGirl.create(:game, game_number: 12345)
      game = Game.find_by_game_number 12345
      expect(game).not_to be_nil
    end

    it 'from api if not in the database' do
      VCR.use_cassette("find_game_by_game_number") do
        game = Game.find_by_game_number 1682396
        expect(game).not_to be_nil
        expect(game.game_number).to eql(1682396)
      end
    end
  end
end
