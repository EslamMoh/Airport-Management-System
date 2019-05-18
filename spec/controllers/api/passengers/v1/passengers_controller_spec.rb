require 'rails_helper'

RSpec.describe Api::Passengers::V1::PassengersController, type: :controller do
  include_context 'API Context'

  describe 'POST /signup' do
    let(:valid_passenger_params) do
      {
        name: Faker::Name.name,
        password: Faker::Internet.password(20, 20),
        phone: '20114' + Kernel.rand(10**7).to_s.rjust(7, '0'),
        email: Faker::Internet.email
      }
    end

    let(:invalid_passenger_params) do
      {
        name: Faker::Name.name,
        password: Faker::Internet.password(20, 20),
        phone: '20114' + Kernel.rand(10**7).to_s.rjust(7, '0')
      }
    end

    context 'creating a passenger' do
      it 'returns an authentication token' do
        post :create, params: valid_passenger_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['auth_token']).not_to be_nil
      end
    end

    context 'creating a passenger using invalid params' do
      it 'returns unprocessable entity with failure message' do
        post :create, params: invalid_passenger_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end
  end

  describe 'GET /passenger' do
    context 'fetch current user data' do
      let(:passenger) { create(:passenger) }
      let(:token) { token_generator(passenger.id, 'Passenger') }
      before(:each) { authorization_header(token) }
      it 'returns current user data' do
        get :show
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(passenger.id)
      end
    end

    context 'fetch current user data without sending token' do
      it 'returns unprocessable entity with failure message' do
        get :show
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end
  end
end
