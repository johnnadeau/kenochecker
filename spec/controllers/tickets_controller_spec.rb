require 'rails_helper'

RSpec.describe TicketsController do

  before(:each) do
    sign_in FactoryGirl.create(:user)
  end

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
    it 'creates a ticket and redirects to tickets listing' do
      FactoryGirl.create(:game, game_number: 666)
      post :create, ticket: { bet_amount: 5, bonus: true,
                              numbers: '1,2,3,4,5', starting_game_number: 666 }
      expect(response).to redirect_to(tickets_path)
    end
    it 'goes back to the form when there are errors' do
      post :create, ticket: { bet_amount: nil }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET show' do
    it 'displays a ticket' do
      game = FactoryGirl.create(:game, game_number: 666)
      ticket = FactoryGirl.create(:ticket, games: [game])
      get :show, id: ticket
      expect(assigns(:ticket)).to eql(ticket)
      expect(response).to render_template(:show)
    end
    it 'redirects to ticket listing if ticket does not exist' do
    end
  end

  describe 'GET edit' do
    it 'displays filled in ticket form' do
      game = FactoryGirl.create(:game, game_number: 666)
      ticket = FactoryGirl.create(:ticket, games: [game])
      get :edit, id: ticket
      expect(assigns(:ticket)).to eql(ticket)
      expect(response).to render_template(:edit)
    end
    it 'redirects to ticket listing if ticket does not exist' do
    end
  end

end
