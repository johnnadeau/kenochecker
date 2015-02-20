class TicketsController < ApplicationController
  before_action :numbers_to_array, only: [:create]

  def index
    @tickets = Ticket.all
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new ticket_params
    puts @ticket.attributes
    if @ticket.save
      redirect_to tickets_path
    else
      render :new
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit! # (:numbers, :bet_amount, :bonus)
  end

  def numbers_to_array
    params[:ticket][:numbers] = params[:ticket][:numbers].split(',').map(&:to_i)
  end
end
