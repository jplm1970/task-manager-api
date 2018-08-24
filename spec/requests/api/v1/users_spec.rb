require 'rails_helper'

RSpec.describe 'Users Api', type: :request do

  let!(:user) { FactoryGirl.create(:user)}
  let(:user_id) { user.id}
  let(:headers) do
    {
      'Accept' => 'application/vnd.taskmanager.v1',
      'Content-Type' => Mime[:json].to_s
    }
  end

  before { host! 'api.task-manager.local'}

  describe 'GET /users/:id' do
    before do

      get "/users/#{user_id}", params: {}, headers: headers
    end

    context 'when the user exists' do
      it 'returns the user' do
      expect(json_body[:id]).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user not exists' do
      let(:user_id) { 10000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end


  end

  describe 'POST /users' do

    before do

      post '/users', params: { user: user_params }.to_json, headers: headers
    end

    context 'when the request parms are valid' do
      let(:user_params) { FactoryGirl.attributes_for(:user) }
      it 'returns code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns json data for the created user' do
        expect(json_body[:email]).to eq(user_params[:email])
      end

    end

    context 'when the request parms are not valid' do
      let(:user_params) { FactoryGirl.attributes_for(:user, email: 'invalid_email@') }
        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
        it 'returns sdata json for errors' do
          expect(json_body).to have_key(:errors)
        end
    end

  end


  describe 'PUT /users/:id' do

    before do

      put "/users/#{user_id}", params: { user: user_params }.to_json, headers: headers
    end

    context 'when the request parms are valid' do
      let(:user_params) { { email: 'email@jp.com' }}
      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'return json data to updated user' do
        expect(json_body[:email]).to eq(user_params[:email])
      end
    end
    context 'when the request parms are not  valid' do
      let(:user_params) { { email: 'ssssss@' }}
      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns sdata json for errors' do
        expect(json_body).to have_key(:errors)
      end
    end
  end


  describe 'DELETE /users/:id' do
    before do

      delete "/users/#{user_id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the use from database' do
      expect( User.find_by(id: user.id)).to be_nil
    end

  end

end