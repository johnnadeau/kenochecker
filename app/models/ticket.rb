class Ticket < ActiveRecord::Base
  NUMBER_RANGE = 1..12
  VALID_NUMBERS = 1..80
  VALID_BET_AMOUNTS = [1, 2, 5, 10, 20]
  MULTIPLIER_COST = 2

  attr_accessor :game_date, :starting_game_number, :ending_game_number
  serialize :numbers, Array

  belongs_to :user
  has_many :games, through: :results
  has_many :results, dependent: :destroy

  validates :numbers, length: { in: NUMBER_RANGE }, unique_array: true,
                      inclusive_array: { range: VALID_NUMBERS }
  validates :bet_amount, inclusion: { in: VALID_BET_AMOUNTS }

  after_find :set_starting_and_ending_game_numbers
  before_create :add_games, if: Proc.new { |ticket| !ticket.games.any? } 

  def total_prize_amount
    if bonus?
      results.to_a.sum(&:prize_amount_with_bonus)
    else
      results.to_a.sum(&:prize_amount)
    end
  end

  def total_bet_amount
    total = bet_amount * games.size
    if bonus?
      total = total * MULTIPLIER_COST
    end
    total
  end

  def game_range
    self.ending_game_number ||= starting_game_number
    (starting_game_number..ending_game_number)
  end

  private

  def add_games
    game_range.each do |game_number|
      games << Game.find_by_game_number(game_number)
    end
  end

  def set_starting_and_ending_game_numbers
    self.starting_game_number = games.first.game_number
    self.ending_game_number = games.last.game_number
  end
end
