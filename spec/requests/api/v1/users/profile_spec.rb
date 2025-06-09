require 'rails_helper'

RSpec.describe 'Api::V1::Users::ProfileController', type: :request do
  describe 'POST /api/v1/users/profile' do
    let(:public_id) { Faker::Alphanumeric.alphanumeric(number: 32) }
    let(:valid_params) do
      {
        user: {
          public_id: public_id
        }
      }
    end

    context 'with valid params' do
      it 'creates a new user' do
        expect {
          post '/api/v1/users/profile', params: valid_params
        }.to change(User, :count).by(1)
      end

      it 'returns status 201' do
        post '/api/v1/users/profile', params: valid_params
        expect(response).to have_http_status(:created)
      end

      it 'returns user data' do
        post '/api/v1/users/profile', params: valid_params
        json = JSON.parse(response.body)

        expect(json['public_id']).to eq(public_id)
        expect(json).not_to have_key('password_digest')
      end
    end

    context 'with invalid params' do
      it 'does not create a user' do
        expect {
          post '/api/v1/users/profile', params: { user: { public_id: '' } }
        }.not_to change(User, :count)
      end

      it 'returns status 422' do
        post '/api/v1/users/profile', params: { user: { public_id: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        post '/api/v1/users/profile', params: { user: { public_id: '' } }
        json = JSON.parse(response.body)

        expect(json).to have_key('error')
      end
    end
  end
end
