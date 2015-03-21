class GamesController < ApplicationController
  before_action :numbers_to_array, only: [:create]

  def index
    @games = Game.all
  end

  def search
  end

  def show
   @game = Game.find_by_game_number(params[:game_number]) 
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new game_params
    if @game.save
      redirect_to games_path
    else
      render :new
    end
  end

  def game_params
    params.require(:game).permit! # (:game_number, :game_date, :bonus, :numbers)
  end

  def numbers_to_array
    if params[:game][:numbers]
      params[:game][:numbers] = params[:game][:numbers].split(',').map(&:to_i)
    end
  end
end
