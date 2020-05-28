require 'rails_helper'

RSpec.describe 'User', type: :request do

  describe 'POST /auth/login' do

    let!(:user) { create(:user) }

    let(:headers) { valid_headers.except('Authorization') }

    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end


    # returns auth token when request is valid
    context 'When request is valid' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        body = JSON.parse(response.body)
        expect(response.status.to_i).to eq(200)
        expect(body['auth_token']).to_not be_nil
      end
    end

    # returns failure message when request is invalid
    context 'When request is invalid' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
          body = JSON.parse(response.body)
          expect(body['status'].to_i).to eq(401)
          expect(body['message']).to eq("Invalid Credentials")
      end
    end
  end
end