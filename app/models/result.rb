class Result < ActiveRecord::Base
  belongs_to :game
  belongs_to :ticket

  validates :game, presence: true
  validates :ticket, presence: true

  def prize_amount
    spots = ticket.numbers.count
    matches = (ticket.numbers & game.numbers).count
    if PRIZES[spots].key? matches
      ticket.bet_amount * PRIZES[spots][matches]
    else
      0
    end
  end

  def prize_amount_with_bonus
    prize_amount * game.bonus
  end
end
