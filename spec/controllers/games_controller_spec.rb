require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    it 'creates a game and redirects to games listing' do
      post :create, game: { game_number: 555666, game_date: '2015-02-19', 
                            bonus: 3, numbers: (1..20).to_a.join(',') }
      expect(response).to redirect_to(games_path)
    end
    it 'goes back to the form when there are errors' do
      post :create, game: { game_number: nil }
      expect(response).to render_template(:new)
    end
  end
end
