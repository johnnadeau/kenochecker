class Result < ActiveRecord::Base
  belongs_to :game
  belongs_to :ticket

  validates_presence_of :game, :ticket

  def prize_amount
    spots = ticket.numbers.count
    matches = (ticket.numbers & game.numbers).count
    ticket.bet_amount * PRIZES[spots][matches]
  end

  def prize_amount_with_bonus
    prize_amount * game.bonus
  end
end
