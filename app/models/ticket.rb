class Ticket < ActiveRecord::Base
  NUMBER_RANGE = 1..12
  VALID_NUMBERS = 1..80
  VALID_BET_AMOUNTS = [1, 2, 5, 10, 20]

  serialize :numbers, Array

  has_and_belongs_to_many :games

  validates :numbers, length: { in: NUMBER_RANGE }, unique_array: true,
                      inclusive_array: { range: VALID_NUMBERS }
  validates :bet_amount, inclusion: { in: VALID_BET_AMOUNTS }
end
