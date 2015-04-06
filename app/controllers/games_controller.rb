class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def search
    @game = Game.find_by_game_number(params[:game_number])
    render :show, @game
  end
end
