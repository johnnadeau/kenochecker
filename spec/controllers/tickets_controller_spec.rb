require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

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
      post :create, ticket: { bet_amount: 5, bonus: true, numbers: '1,2,3,4,5' }
      expect(response).to redirect_to(tickets_path)
    end
    it 'goes back to the form when there are errors' do
      post :create, ticket: { bet_amount: nil }
      expect(response).to render_template(:new)
    end
  end
end
