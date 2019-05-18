require 'rails_helper'

RSpec.describe Api::Users::V1::AirlinesController, type: :controller do
  include_context 'API Context'
  let!(:user) { create(:user) }
  let(:token) { token_generator(user.id, 'User') }
  let!(:first_airline) { create(:airline) }
  let!(:second_airline) { create(:airline) }

  describe 'GET /airlines' do
    context 'fetching airlines' do
      before(:each) { authorization_header(token) }
      it 'returns list of airlines' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['records'].size).to eq(2)
      end
    end

    context 'fetching airlines without token' do
      it 'returns unprocessable entity with failure message' do
        get :index
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end
  end

  describe 'GET /airlines/:id' do
    context 'fetching airline by airline id' do
      before(:each) { authorization_header(token) }
      it 'returns airline' do
        get :show, params: { id: first_airline.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_airline.id)
      end
    end

    context 'fetching airline by its id without token' do
      it 'returns unprocessable entity' do
        get :show, params: { id: first_airline.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'fetching airline by invalid airline id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        get :show, params: { id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /airlines' do
    let(:airline_params) do
      {
        name: Faker::Company.name,
        origin_country: Faker::Address.country
      }
    end
    let(:invalid_airline_params) do
      {
        origin_country: Faker::Address.country
      }
    end
    context 'create airline' do
      before(:each) { authorization_header(token) }
      it 'returns created airline' do
        post :create, params: airline_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['id']).to eq(Airline.last.id)
      end
    end

    context 'create airline without token' do
      it 'returns unprocessable entity' do
        post :create
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'create airline using invalid params' do
      before(:each) { authorization_header(token) }
      it 'returns created airline' do
        post :create, params: invalid_airline_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body))
          .not_to be_nil
      end
    end
  end

  describe 'PUT /airlines/:id' do
    let(:airline_params) do
      {
        name: Faker::Company.name,
        origin_country: Faker::Address.country
      }
    end
    context 'updating airline by airline id' do
      before(:each) { authorization_header(token) }
      it 'returns airline' do
        put :update, params: { id: first_airline.id, airline: airline_params }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_airline.id)
      end
    end

    context 'updating airline by its id without token' do
      it 'returns unprocessable entity' do
        put :update, params: { id: first_airline.id, airline: airline_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'updating airline by invalid airline id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        put :update, params: { id: Faker::Number.number(2),
                               airline: airline_params }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
