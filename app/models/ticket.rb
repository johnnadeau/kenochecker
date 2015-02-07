class Ticket < ActiveRecord::Base
  NUMBER_RANGE = 1..12
  VALID_NUMBERS = 1..80
  VALID_BET_AMOUNTS = [1, 2, 5, 10, 20]

  serialize :numbers, Array

  has_many :games, through: :results
  has_many :results

  validates :numbers, length: { in: NUMBER_RANGE }, unique_array: true,
                      inclusive_array: { range: VALID_NUMBERS }
  validates :bet_amount, inclusion: { in: VALID_BET_AMOUNTS }

  def total_prize_amount
    if bonus?
      results.to_a.sum { |r| r.prize_amount_with_bonus }
    else
      results.to_a.sum { |r| r.prize_amount }
    end
  end
end
