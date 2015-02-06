class Game < ActiveRecord::Base
  NUMBER_COUNT = 20
  VALID_NUMBERS = 1..80
  VALID_BONUS_MULTIPLIERS = [1, 3, 4, 5, 10]

  serialize :numbers, Array

  validates_presence_of :game_number, :game_date
  validates :numbers, length: { is: NUMBER_COUNT }
  validate :numbers_are_valid, :numbers_are_unique
  validates :bonus, inclusion: { in: VALID_BONUS_MULTIPLIERS }

  private

  def numbers_are_valid
    if numbers.any? { |n| !VALID_NUMBERS.include? n }
      errors.add(:numbers, 'all numbers must be within 1..80')
    end
  end

  def numbers_are_unique
    if numbers.uniq.count < NUMBER_COUNT
      errors.add(:numbers, 'all numbers must be unique')
    end
  end
end
