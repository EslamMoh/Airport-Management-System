require 'rails_helper'

RSpec.describe Api::Users::V1::UsersController, type: :controller do
  include_context 'API Context'

  describe 'POST /signup' do
    let(:valid_user_params) do
      {
        name: Faker::Name.name,
        password: Faker::Internet.password(20, 20),
        phone: '20114' + Kernel.rand(10**7).to_s.rjust(7, '0'),
        email: Faker::Internet.email
      }
    end

    let(:invalid_user_params) do
      {
        name: Faker::Name.name,
        password: Faker::Internet.password(20, 20),
        phone: '20114' + Kernel.rand(10**7).to_s.rjust(7, '0')
      }
    end

    context 'creating a user' do
      it 'returns an authentication token' do
        post :create, params: valid_user_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['auth_token']).not_to be_nil
      end
    end

    context 'creating a user using invalid params' do
      it 'returns unprocessable entity with failure message' do
        post :create, params: invalid_user_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['message'])
          .not_to be_nil
      end
    end
  end

  describe 'GET /user' do
    context 'fetch current user data' do
      let(:user) { create(:user) }
      let(:token) { token_generator(user.id, 'User') }
      before(:each) { authorization_header(token) }
      it 'returns current user data' do
        get :show
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(user.id)
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
