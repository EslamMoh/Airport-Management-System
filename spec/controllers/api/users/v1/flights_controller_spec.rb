require 'rails_helper'

RSpec.describe Api::Users::V1::FlightsController, type: :controller do
  include_context 'API Context'
  let!(:user) { create(:user) }
  let(:token) { token_generator(user.id, 'User') }
  let!(:first_flight) { create(:flight, user: user) }
  let!(:second_flight) { create(:flight, user: user) }

  describe 'GET /flights' do
    context 'fetching current user flights' do
      before(:each) { authorization_header(token) }
      it 'returns list of flights' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['records'].size).to eq(2)
      end
    end

    context 'fetching current user flights without token' do
      it 'returns unprocessable entity with failure message' do
        get :index
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end
  end

  describe 'GET /flights/:id' do
    context 'fetching flight by flight id' do
      before(:each) { authorization_header(token) }
      it 'returns flight' do
        get :show, params: { id: first_flight.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_flight.id)
      end
    end

    context 'fetching flight by its id without token' do
      it 'returns unprocessable entity' do
        get :show, params: { id: first_flight.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'fetching flight by invalid flight id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        get :show, params: { id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /flights' do
    let(:departure_airport) { create(:airport) }
    let(:destination_airport) { create(:airport) }
    let(:flight_params) do
      {
        user_id: user.id,
        name: Faker::Number.number(3),
        price: 500,
        flight_type: 'stop',
        direction_type: 'one_way',
        departure_country: Faker::Address.country,
        destination_country: Faker::Address.country,
        departure_airport_id: departure_airport.id,
        destination_airport_id: destination_airport.id,
        departure_time: rand(10).day.from_now,
        arrival_time: rand(10).day.from_now,
        tickets_count: 200
      }
    end
    let(:invalid_flight_params) do
      {
        user_id: user.id,
        name: Faker::Number.number(3),
        price: 500,
        flight_type: 'stop',
        direction_type: 'one_way'
      }
    end
    context 'create flight' do
      before(:each) { authorization_header(token) }
      it 'returns created flight' do
        post :create, params: flight_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['id']).to eq(Flight.last.id)
      end
    end

    context 'create flight without token' do
      it 'returns unprocessable entity' do
        post :create
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'create flight using invalid params' do
      before(:each) { authorization_header(token) }
      it 'returns created flight' do
        post :create, params: invalid_flight_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body))
          .not_to be_nil
      end
    end
  end

  describe 'PUT /flights/:id' do
    let(:flight_params) do
      {
        user_id: user.id,
        name: Faker::Number.number(3),
        price: 500,
        flight_type: 'stop',
        direction_type: 'one_way',
        departure_country: Faker::Address.country,
        destination_country: Faker::Address.country,
        departure_time: rand(10).day.from_now,
        arrival_time: rand(10).day.from_now,
        tickets_count: 200
      }
    end
    context 'updating flight by flight id' do
      before(:each) { authorization_header(token) }
      it 'returns flight' do
        put :update, params: { id: first_flight.id,
                               flight: flight_params }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_flight.id)
      end
    end

    context 'updating flight by its id without token' do
      it 'returns unprocessable entity' do
        put :update, params: { id: first_flight.id,
                               flight: flight_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'updating flight by invalid flight id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        put :update, params: { id: Faker::Number.number(2),
                               flight: flight_params }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /flights/:id' do
    context 'deleting flight by flight id' do
      before(:each) { authorization_header(token) }
      it 'returns flight' do
        delete :destroy, params: { id: first_flight.id }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'deleting flight by its id without token' do
      it 'returns unprocessable entity' do
        delete :destroy, params: { id: first_flight.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'deleting flight by invalid flight id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        delete :destroy, params: { id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /flights/flight_executions/:id' do
    let!(:flight_execution) { create(:flight_execution) }
    context 'add flight execution to flight by ids' do
      before(:each) { authorization_header(token) }
      it 'returns flight' do
        post :add_flight_executions,
             params: { id: first_flight.id,
                       flight_executions_ids: [flight_execution.id] }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['id']).to eq(first_flight.id)
      end
    end

    context 'add flight execution to flight by ids without token' do
      it 'returns unprocessable entity' do
        post :add_flight_executions,
             params: { id: first_flight.id,
                       flight_executions_ids: [flight_execution.id] }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'add flight execution to flight by invalid ids' do
      before(:each) { authorization_header(token) }
      it 'returns not found entity' do
        post :add_flight_executions,
             params: { id: Faker::Number.number(2),
                       flight_executions_ids: [flight_execution.id] }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /flights/flight_executions/:id/:flight_execution_id' do
    let(:flight) { create(:flight, user: user)}
    let(:flight_execution) { create(:flight_execution, user: user)}
    let(:flight_flight_execution) do
      create(:flight_flight_execution, flight: flight, flight_execution: flight_execution)
    end
    context 'remove flight execution from flight by ids' do
      before(:each) { authorization_header(token) }
      it 'returns no content' do
        delete :remove_flight_execution,
               params: { id: flight_flight_execution.flight_id,
                         flight_execution_id: flight_flight_execution
                           .flight_execution_id }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'remove flight execution from flight by ids without token' do
      it 'returns unprocessable entity' do
        delete :remove_flight_execution,
               params: { id: flight_flight_execution.flight_id,
                         flight_execution_id: flight_flight_execution
                           .flight_execution_id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'remove flight execution from flight by invalid ids' do
      before(:each) { authorization_header(token) }
      it 'returns not found entity' do
        delete :remove_flight_execution,
               params: { id: Faker::Number.number(2),
                         flight_execution_id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
