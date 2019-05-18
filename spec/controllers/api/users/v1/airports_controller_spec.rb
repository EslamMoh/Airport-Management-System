require 'rails_helper'

RSpec.describe Api::Users::V1::AirportsController, type: :controller do
  include_context 'API Context'
  let!(:user) { create(:user) }
  let(:token) { token_generator(user.id, 'User') }
  let!(:first_airport) { create(:airport, user: user) }
  let!(:second_airport) { create(:airport, user: user) }

  describe 'GET /airports' do
    context 'fetching current user airports' do
      before(:each) { authorization_header(token) }
      it 'returns list of airports' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['records'].size).to eq(2)
      end
    end

    context 'fetching current user airports without token' do
      it 'returns unprocessable entity with failure message' do
        get :index
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end
  end

  describe 'GET /airports/:id' do
    context 'fetching airport by airport id' do
      before(:each) { authorization_header(token) }
      it 'returns airport' do
        get :show, params: { id: first_airport.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_airport.id)
      end
    end

    context 'fetching airport by its id without token' do
      it 'returns unprocessable entity' do
        get :show, params: { id: first_airport.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'fetching airport by invalid airport id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        get :show, params: { id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /airports' do
    let(:airport_params) do
      {
        user_id: user.id,
        name: Faker::Company.name,
        city: Faker::Address.city,
        country: Faker::Address.country
      }
    end
    let(:invalid_airport_params) do
      {
        user_id: user.id
      }
    end
    context 'create airport' do
      before(:each) { authorization_header(token) }
      it 'returns created airport' do
        post :create, params: airport_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['id']).to eq(Airport.last.id)
      end
    end

    context 'create airport without token' do
      it 'returns unprocessable entity' do
        post :create
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'create airport using invalid params' do
      before(:each) { authorization_header(token) }
      it 'returns created airport' do
        post :create, params: invalid_airport_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body))
          .not_to be_nil
      end
    end
  end

  describe 'PUT /airports/:id' do
    let(:airport_params) do
      {
        user_id: user.id,
        name: Faker::Company.name,
        city: Faker::Address.city,
        country: Faker::Address.country
      }
    end
    context 'updating airport by airport id' do
      before(:each) { authorization_header(token) }
      it 'returns airport' do
        put :update, params: { id: first_airport.id,
                               airport: airport_params }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_airport.id)
      end
    end

    context 'updating airport by its id without token' do
      it 'returns unprocessable entity' do
        put :update, params: { id: first_airport.id,
                               airport: airport_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'updating airport by invalid airport id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        put :update, params: { id: Faker::Number.number(2),
                               airport: airport_params }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /airports/:id' do
    context 'deleting airport by airport id' do
      before(:each) { authorization_header(token) }
      it 'returns airport' do
        delete :destroy, params: { id: first_airport.id }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'deleting airport by its id without token' do
      it 'returns unprocessable entity' do
        delete :destroy, params: { id: first_airport.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'deleting airport by invalid airport id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        delete :destroy, params: { id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /airports/airlines/:id/:airline_id' do
    let(:airline) { create(:airline) }
    context 'add airline to airport by ids' do
      before(:each) { authorization_header(token) }
      it 'returns airport' do
        post :add_airport_airlines,
             params: { id: first_airport, airline_id: airline.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_airport.id)
      end
    end

    context 'add airline to airport by ids without token' do
      it 'returns unprocessable entity' do
        post :add_airport_airlines,
             params: { id: first_airport, airline_id: airline.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'add airline to airport by invalid ids without token' do
      before(:each) { authorization_header(token) }
      it 'returns not found entity' do
        post :add_airport_airlines,
             params: { id: Faker::Number.number(2),
                       airline_id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /airports/airlines/:id/:airline_id' do
    let(:airport) { create(:airport, user: user) }
    let(:airline) { create(:airline) }
    let(:airport_airline) do
      create(:airport_airline, airport: airport, airline: airline)
    end
    context 'remove airline from airport by ids' do
      before(:each) { authorization_header(token) }
      it 'returns airport' do
        delete :remove_airport_airline,
               params: { id: airport_airline.airport_id,
                         airline_id: airport_airline.airline_id }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'remove airline from airport by ids without token' do
      it 'returns unprocessable entity' do
        delete :remove_airport_airline,
               params: { id: airport_airline.airport_id,
                         airline_id: airport_airline.airline_id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'remove airline from airport by invalid ids without token' do
      before(:each) { authorization_header(token) }
      it 'returns not found entity' do
        delete :remove_airport_airline,
               params: { id: Faker::Number.number(2),
                         airline_id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
