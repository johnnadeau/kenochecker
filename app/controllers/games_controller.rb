class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def search
    @game = Game.find_by_game_number(params[:game_number])
    render :show, @game
  end

  def show
   @game = Game.find(params[:id]) 
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

end
