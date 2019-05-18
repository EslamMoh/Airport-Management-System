require 'rails_helper'

RSpec.describe Api::Users::V1::TerminalsController, type: :controller do
  include_context 'API Context'
  let!(:user) { create(:user) }
  let(:token) { token_generator(user.id, 'User') }
  let(:airport) { create(:airport, user: user) }
  let!(:first_terminal) { create(:terminal, airport: airport) }
  let!(:second_terminal) { create(:terminal, airport: airport) }

  describe 'GET /terminals' do
    context 'fetching airport terminals' do
      before(:each) { authorization_header(token) }
      it 'returns list of terminals' do
        get :index, params: { airport_id: airport.id}
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['records'].size).to eq(2)
      end
    end

    context 'fetching terminals without token' do
      it 'returns unprocessable entity with failure message' do
        get :index, params: { airport_id: airport.id}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end
  end

  describe 'GET /terminals/:airport_id/:id' do
    context 'fetching terminal by terminal id and airport id' do
      before(:each) { authorization_header(token) }
      it 'returns terminal' do
        get :show, params: { id: first_terminal.id,
                             airport_id: airport.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_terminal.id)
      end
    end

    context 'fetching terminal by its id without token' do
      it 'returns unprocessable entity' do
        get :show, params: { id: first_terminal.id,
                             airport_id: airport.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'fetching terminal by invalid terminal id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        get :show, params: { id: Faker::Number.number(2),
                             airport_id: airport.id }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /terminals/:airport_id' do
    let(:terminal_params) do
      {
        name: 'Hall 1'
      }
    end
    let(:invalid_terminal_params) do
      {
        description: 'This is a test description'
      }
    end
    context 'create terminal' do
      before(:each) { authorization_header(token) }
      it 'returns created terminal' do
        post :create, params: { terminal: terminal_params,
                                airport_id: airport.id }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['id']).to eq(Terminal.last.id)
      end
    end

    context 'create terminal without token' do
      it 'returns unprocessable entity' do
        post :create, params: { terminal: terminal_params,
                                airport_id: airport.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'create terminal using invalid params' do
      before(:each) { authorization_header(token) }
      it 'returns created terminal' do
        post :create, params: { terminal: invalid_terminal_params,
                                airport_id: airport.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body))
          .not_to be_nil
      end
    end
  end

  describe 'PUT /terminals/:airport_id/:id' do
    let(:terminal_params) do
      {
        name: 'Hall 1'
      }
    end
    context 'updating terminal by terminal id and airport id' do
      before(:each) { authorization_header(token) }
      it 'returns terminal' do
        put :update, params: { id: first_terminal.id,
                               airport_id: airport.id,
                               terminal: terminal_params }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(first_terminal.id)
      end
    end

    context 'updating terminal by its id and airport id without token' do
      it 'returns unprocessable entity' do
        put :update, params: { id: first_terminal.id,
                               airport_id: airport.id,
                               terminal: terminal_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'updating terminal by invalid terminal id and airport id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        put :update, params: { id: Faker::Number.number(2),
                               airport_id: airport.id,
                               terminal: terminal_params }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /terminals/:airport_id/:id' do
    context 'deleting terminal by terminal id and airport id' do
      before(:each) { authorization_header(token) }
      it 'returns no content' do
        delete :destroy, params: { id: first_terminal.id,
                                   airport_id: airport.id }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'deleting terminal by its id and airport id without token' do
      it 'returns unprocessable entity' do
        delete :destroy, params: { id: first_terminal.id,
                                   airport_id: airport.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end

    context 'deleting terminal by invalid terminal id' do
      before(:each) { authorization_header(token) }
      it 'returns not found' do
        delete :destroy, params: { id: Faker::Number.number(2),
                                   airport_id: Faker::Number.number(2) }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
