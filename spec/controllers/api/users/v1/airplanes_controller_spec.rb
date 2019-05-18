require 'rails_helper'

RSpec.describe Api::Users::V1::AirplanesController, type: :controller do
  include_context 'API Context'
  let!(:user) { create(:user) }
  let(:token) { token_generator(user.id, 'User') }
  let!(:first_airplane) { create(:airplane) }
  let!(:second_airplane) { create(:airplane) }

  describe 'GET /airplanes' do
    context 'fetching airplanes' do
      before(:each) { authorization_header(token) }
      it 'returns list of airplanes' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['records'].size).to eq(2)
      end
    end

    context 'fetching airplanes without token' do
      it 'returns unprocessable entity with failure message' do
        get :index
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end
  end

  describe 'GET /airplanes/:id' do
    context 'fetching airplane by airplane id' do
      before(:each) { authorization_header(token) }
      it 'returns airplane' do
        get :show, params: { id: first_airplane.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_airplane.id)
      end
    end

    context 'fetching airplane by its id without token' do
      it 'returns unprocessable entity' do
        get :show, params: { id: first_airplane.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'fetching airplane by invalid airplane id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        get :show, params: { id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /airplanes' do
    let(:airline) { create(:airline) }
    let(:airplane_params) do
      {
        airline_id: airline.id,
        manufacturer: Faker::Company.name,
        model_number: Faker::Number.number(10),
        capacity: Faker::Number.number(3)
      }
    end
    let(:invalid_airplane_params) do
      {
        airline_id: airline.id,
        capacity: Faker::Number.number(3)
      }
    end
    context 'create airplane' do
      before(:each) { authorization_header(token) }
      it 'returns created airplane' do
        post :create, params: airplane_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['id']).to eq(Airplane.last.id)
      end
    end

    context 'create airplane without token' do
      it 'returns unprocessable entity' do
        post :create
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'create airplane using invalid params' do
      before(:each) { authorization_header(token) }
      it 'returns created airplane' do
        post :create, params: invalid_airplane_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body))
          .not_to be_nil
      end
    end
  end

  describe 'PUT /airplanes/:id' do
    let(:airline) { create(:airline) }
    let(:airplane_params) do
      {
        airline_id: airline.id,
        manufacturer: Faker::Company.name,
        model_number: Faker::Number.number(10),
        capacity: Faker::Number.number(3)
      }
    end
    context 'updating airplane by airplane id' do
      before(:each) { authorization_header(token) }
      it 'returns airplane' do
        put :update, params: { id: first_airplane.id,
                               airplane: airplane_params }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_airplane.id)
      end
    end

    context 'updating airplane by its id without token' do
      it 'returns unprocessable entity' do
        put :update, params: { id: first_airplane.id,
                               airplane: airplane_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'updating airplane by invalid airplane id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        put :update, params: { id: Faker::Number.number(2),
                               airplane: airplane_params }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /airplanes/:id' do
    context 'deleting airplane by airplane id' do
      before(:each) { authorization_header(token) }
      it 'returns no content' do
        delete :destroy, params: { id: first_airplane.id }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'deleting airplane by its id without token' do
      it 'returns unprocessable entity' do
        delete :destroy, params: { id: first_airplane.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'deleting airplane by invalid airplane id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        delete :destroy, params: { id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
