require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET show' do
    it 'displays a game' do
      game = FactoryGirl.create(:game)
      get :show, { id: game.id }
      expect(assigns(:game)).to eql(game)
      expect(response).to render_template(:show)
    end
    it 'redirects to game listing if game does not exist' do
    end
  end

  describe 'GET search' do
    it 'displays a game' do
      game = FactoryGirl.create(:game)
      get :search, game: { game_number: game.game_number }
      expect(assigns(:game)).to eql(game)
      expect(response).to render_template(:show)
    end
  end
end
