require 'rails_helper'

RSpec.describe Api::Passengers::V1::TicketsController, type: :controller do
  include_context 'API Context'
  let!(:passenger) { create(:passenger) }
  let!(:first_ticket) { create(:ticket, passenger: passenger) }
  let!(:second_ticket) { create(:ticket, passenger: passenger) }
  let(:token) { token_generator(passenger.id, 'Passenger') }

  describe 'GET /tickets' do
    context 'fetching current passenger tickets' do
      before(:each) { authorization_header(token) }
      it 'returns list of tickets' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['records'].size).to eq(2)
      end
    end

    context 'fetching current passenger tickets without token' do
      it 'returns unprocessable entity with failure message' do
        get :index
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end
  end

  describe 'GET /tickets/:id' do
    context 'fetching current passenger ticket by ticket id' do
      before(:each) { authorization_header(token) }
      it 'returns ticket' do
        get :show, params: { id: first_ticket.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_ticket.id)
      end
    end

    context 'fetching current passenger ticket by ticket id without token' do
      it 'returns unprocessable entity' do
        get :show, params: { id: first_ticket.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'fetching current passenger ticket by invalid ticket id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        get :show, params: { id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /tickets' do
    let(:flight) { create(:flight) }
    let(:ticket_params) do
      {
        flight_id: flight.id
      }
    end
    context 'create ticket for current passenger' do
      before(:each) { authorization_header(token) }
      it 'returns created ticket' do
        post :create, params: ticket_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['id']).to eq(Ticket.last.id)
      end
    end

    context 'create ticket for current passenger without token' do
      it 'returns unprocessable entity' do
        post :create
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end
  end

  describe 'POST /tickets/:id' do
    context 'confirm current passenger ticket by ticket id' do
      before(:each) { authorization_header(token) }
      it 'returns ticket' do
        post :confirm, params: { id: first_ticket.id }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['id']).to eq(first_ticket.id)
      end
    end

    context 'confirm current passenger ticket by ticket id without token' do
      it 'returns unprocessable entity' do
        post :confirm, params: { id: first_ticket.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'confirm passenger ticket by invalid ticket id without token' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        post :confirm, params: { id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end
  end
end
