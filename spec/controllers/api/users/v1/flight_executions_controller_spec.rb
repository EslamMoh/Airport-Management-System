require 'rails_helper'

RSpec.describe Api::Users::V1::FlightExecutionsController, type: :controller do
  include_context 'API Context'
  let!(:user) { create(:user) }
  let(:token) { token_generator(user.id, 'User') }
  let!(:first_flight_execution) { create(:flight_execution, user: user) }
  let!(:second_flight_execution) { create(:flight_execution, user: user) }

  describe 'GET /flight_executions' do
    context 'fetching current user flight_executions' do
      before(:each) { authorization_header(token) }
      it 'returns list of flight_executions' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['records'].size).to eq(2)
      end
    end

    context 'fetching current user flight_executions without token' do
      it 'returns unprocessable entity with failure message' do
        get :index
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end
  end

  describe 'GET /flight_executions/:id' do
    context 'fetching flight_execution by flight_execution id' do
      before(:each) { authorization_header(token) }
      it 'returns flight_execution' do
        get :show, params: { id: first_flight_execution.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_flight_execution.id)
      end
    end

    context 'fetching flight_execution by its id without token' do
      it 'returns unprocessable entity' do
        get :show, params: { id: first_flight_execution.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'fetching flight_execution by invalid flight_execution id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        get :show, params: { id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /flight_executions' do
    let(:airplane) { create(:airplane) }
    let(:departure_terminal) { create(:terminal) }
    let(:destination_terminal) { create(:terminal) }
    let(:flight_execution_params) do
      {
        user_id: user.id,
        airplane_id: airplane.id,
        departure_terminal_id: departure_terminal.id,
        destination_terminal_id: destination_terminal.id,
        departure_time: rand(10).day.from_now,
        arrival_time: rand(10).day.from_now
      }
    end
    let(:invalid_flight_execution_params) do
      {
        user_id: user.id,
        departure_terminal_id: departure_terminal.id,
        destination_terminal_id: destination_terminal.id,
        arrival_time: rand(10).day.from_now
      }
    end
    context 'create flight_execution' do
      before(:each) { authorization_header(token) }
      it 'returns created flight_execution' do
        post :create, params: flight_execution_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['id']).to eq(FlightExecution.last.id)
      end
    end

    context 'create flight_execution without token' do
      it 'returns unprocessable entity' do
        post :create
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'create flight_execution using invalid params' do
      before(:each) { authorization_header(token) }
      it 'returns created flight_execution' do
        post :create, params: invalid_flight_execution_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body))
          .not_to be_nil
      end
    end
  end

  describe 'PUT /flight_executions/:id' do
    let(:flight_execution_params) do
      {
        departure_time: rand(10).day.from_now,
        arrival_time: rand(10).day.from_now
      }
    end
    context 'updating flight_execution by flight_execution id' do
      before(:each) { authorization_header(token) }
      it 'returns flight_execution' do
        put :update, params: { id: first_flight_execution.id,
                               flight_execution: flight_execution_params }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_flight_execution.id)
      end
    end

    context 'updating flight_execution by its id without token' do
      it 'returns unprocessable entity' do
        put :update, params: { id: first_flight_execution.id,
                               flight_execution: flight_execution_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'updating flight_execution by invalid flight_execution id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        put :update, params: { id: Faker::Number.number(2),
                               flight_execution: flight_execution_params }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /flight_executions/:id' do
    context 'deleting flight_execution by flight_execution id' do
      before(:each) { authorization_header(token) }
      it 'returns flight_execution' do
        delete :destroy, params: { id: first_flight_execution.id }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'deleting flight_execution by its id without token' do
      it 'returns unprocessable entity' do
        delete :destroy, params: { id: first_flight_execution.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'deleting flight_execution by invalid flight_execution id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        delete :destroy, params: { id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /flight_executions/seats/:id' do
    context 'fetching flight_execution seats by flight_execution id' do
      before(:each) { authorization_header(token) }
      it 'returns flight_execution seats' do
        get :seats, params: { id: first_flight_execution.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['records'].size).to eq(first_flight_execution.seats.size)
      end
    end

    context 'fetching flight_execution seats by its id without token' do
      it 'returns unprocessable entity' do
        get :seats, params: { id: first_flight_execution.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'fetching flight_execution seats by invalid flight_execution id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        get :seats, params: { id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
