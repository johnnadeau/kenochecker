class Result < ActiveRecord::Base
  belongs_to :game
  belongs_to :ticket

  validates_presence_of :game, :ticket

  def amount
    spots = ticket.numbers.count
    matches = (ticket.numbers & game.numbers).count
    ticket.bet_amount * PRIZES[spots][matches]
  end
end
