module TicketsHelper
  MULTIPLIER_COST = 2

  def ticket_numbers
    @ticket.numbers.join(' ')
  end

  def multiplier
    if @ticket.bonus?
      'Multiplier'
    else
      'No Multiplier'
    end
  end

end
