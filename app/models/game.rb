class Game < ActiveRecord::Base
  NUMBER_COUNT = 20
  VALID_NUMBERS = 1..80
  VALID_BONUS_MULTIPLIERS = [1, 3, 4, 5, 10]

  serialize :numbers, Array

  has_and_belongs_to_many :tickets

  validates_presence_of :game_number, :game_date
  validates :numbers, length: { is: NUMBER_COUNT }, unique_array: true,
                      inclusive_array: { range: VALID_NUMBERS }
  validates :bonus, inclusion: { in: VALID_BONUS_MULTIPLIERS }
end
