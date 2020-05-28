require 'rails_helper'

RSpec.describe 'Tweets API' do

  let(:user) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user2) }
  let(:admin) { FactoryBot.create(:admin) }
  let(:token) { { 'Authorization' => token_generator(user.id) } }
  let(:admin_token) { { 'Authorization' => token_generator(admin.id) } }
  let(:user2_token) { { 'Authorization' => token_generator(user2.id) } }
  let(:tweet) { FactoryBot.create(:tweet, comment: Faker::Lorem.sentence, user_id: user.id) }
  let(:user_id) { user.id }
  let(:admin_id) { admin.id }
  let(:id) { tweet.first.id }
  let(:params) do
    {
      tweet: {
        comment: Faker::Lorem.sentence
      }
    }
  end

  context 'GET /tweets' do
    it 'should return all the Tweets of user' do
      get '/tweets', headers: token 
      body = JSON.parse(response.body)
      expect(response.code.to_i).to eq(200)
    end
  end

  context 'GET tweets/:id' do

    it 'should return 204 if tweet is not present' do
      get '/tweets/' + "10", headers: token
      body = JSON.parse(response.body)
      expect(body['status']).to eq(203)
      expect(body['message']).to eq('Tweet not Present')
    end

    it 'should return 204 if tweet is present' do
      get '/tweets/' + tweet.id.to_s, headers: token
      body = JSON.parse(response.body)
      expect(response.code.to_i).to eq(200)
    end

    it 'should return Tweet if admin access' do
      get '/tweets/' + tweet.id.to_s, headers: admin_token
      body = JSON.parse(response.body)
      expect(response.code.to_i).to eq(200)
    end

    it 'should return Tweet if admin access' do
      get '/tweets/' + tweet.id.to_s, headers: user2_token
      body = JSON.parse(response.body)
      expect(response.code.to_i).to eq(200)
    end
  end


  # context 'PUT /tweets/:id' do
  #   it 'should return 401 Unauthorized' do
  #     put '/tweets/' + tweet.id.to_s, params: params, headers: user2_token
  #     body = JSON.parse(response.body)
  #     expect(response.code.to_i).to eq(401)
  #     expect(body['error']).to eq(I18n.t('errors.unauthorized'))
  #   end
  # end
  
end