require 'rails_helper'

RSpec.describe Api::Passengers::V1::FlightsController, type: :controller do
  include_context 'API Context'
  let!(:first_flight) { create(:flight) }
  let!(:second_flight) { create(:flight) }

  describe 'GET /flights' do
    context 'When request is valid' do
      it 'returns a list of flights' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['records'].size).to eq(2)
      end
    end
  end

  describe 'GET /flights/:id' do
    context 'When request is valid' do
      it 'returns a flight with the id' do
        get :show, params: { id: first_flight.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_flight.id)
      end
    end

    context 'When requesting an invalid flight' do
      it 'returns a not found status' do
        get :show, params: { id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
