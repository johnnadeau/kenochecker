class Result < ActiveRecord::Base
  belongs_to :game
  belongs_to :ticket

  validates_presence_of :game, :ticket
  validates :amount, numericality: { greater_than_or_equal_to: 0.00 }
end
