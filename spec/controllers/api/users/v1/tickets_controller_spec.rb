require 'rails_helper'

RSpec.describe Api::Users::V1::TicketsController, type: :controller do
  include_context 'API Context'
  let!(:user) { create(:user) }
  let(:token) { token_generator(user.id, 'User') }
  let!(:flight) { create(:flight, user: user) }
  let!(:first_ticket) { create(:ticket, flight: flight) }
  let!(:second_ticket) { create(:ticket, flight: flight) }

  describe 'GET /tickets/:flight_id' do
    context 'fetching flight tickets' do
      before(:each) { authorization_header(token) }
      it 'returns list of tickets' do
        get :index, params: { flight_id: flight.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['records'].size).to eq(2)
      end
    end

    context 'fetching flight tickets without token' do
      it 'returns unprocessable entity with failure message' do
        get :index, params: { flight_id: flight.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end
  end

  describe 'POST /tickets/:airport_id' do
    let(:passenger) { create(:passenger) }
    let(:ticket_params) do
      {
        email: passenger.email,
        flight_id: flight.id
      }
    end
    let(:invalid_ticket_params) do
      {
        email: 'test@gmail.com',
        flight_id: flight.id
      }
    end
    context 'create ticket' do
      before(:each) { authorization_header(token) }
      it 'returns created ticket' do
        post :create, params: ticket_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['id']).to eq(Ticket.last.id)
      end
    end

    context 'create ticket without token' do
      it 'returns unprocessable entity' do
        post :create, params: ticket_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'create ticket using invalid params' do
      before(:each) { authorization_header(token) }
      it 'returns created ticket' do
        post :create, params: invalid_ticket_params
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body))
          .not_to be_nil
      end
    end
  end
end
