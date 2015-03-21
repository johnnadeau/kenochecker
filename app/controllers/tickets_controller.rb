class TicketsController < ApplicationController
  before_action :numbers_to_array, only: [:create]

  def index
    @tickets = current_user.tickets
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = current_user.tickets.build ticket_params
    if @ticket.save
      redirect_to tickets_path
    else
      render :new
    end
  end
  
  def edit
    @ticket = Ticket.find(params[:id])
    @ticket.starting_game_number = @ticket.games.first.game_number
    @ticket.ending_game_number = @ticket.games.last.game_number
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  private

  def ticket_params
    params.require(:ticket).permit! # (:numbers, :bet_amount, :bonus)
  end

  def numbers_to_array
    if params[:ticket][:numbers]
      params[:ticket][:numbers] = params[:ticket][:numbers].split(',').map(&:to_i)
    end
  end
end
