require 'rails_helper'

RSpec.describe Api::V1::DevelopersController, type: :controller do
  render_views

  let(:valid_attributes) do
    {
      username: 'a_silverback_gorilla',
      email: 'not.a.monkey@gmail.com',
      password: 'bananas123'
    }
  end
  let(:invalid_attributes) {{ foo: 'bar' }}
  let!(:developer) { FactoryGirl.create(:developer) }
  let(:json) { JSON.parse(response.body) }

  # let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, format: :json #, session: valid_session

      expect(response).to be_success

      json_response = json['data'][0]
      expect(json_response['id']).to eq(developer.id)
      expect(json_response['attributes']).to eq({ "username" => developer.username, "email" => developer.email })
      expect(json_response['link']).to eq("http://test.host/api/v1/developers/#{developer.id}")
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: developer.to_param } #, session: valid_session
      expect(response).to be_success
      expect(json['data'].keys).to eq(["type", "id", "created_at", "updated_at", "attributes", "applications", "link"])
      expect(json['data']['attributes']).to eq({ "username" => developer.username, "email" => developer.email })
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Developer' do
        expect {
          post :create, params: {developer: valid_attributes}, session: valid_session
        }.to change(Developer, :count).by(1)
      end

      it 'renders a JSON response with the new developer' do

        post :create, params: {developer: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(developer_url(Developer.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new developer' do

        post :create, params: {developer: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        skip('Add a hash of attributes valid for your model')
      }

      it 'updates the requested developer' do
        developer = Developer.create! valid_attributes
        put :update, params: {id: developer.to_param, developer: new_attributes}, session: valid_session
        developer.reload
        skip('Add assertions for updated state')
      end

      it 'renders a JSON response with the developer' do
        developer = Developer.create! valid_attributes

        put :update, params: {id: developer.to_param, developer: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the developer' do
        developer = Developer.create! valid_attributes

        put :update, params: {id: developer.to_param, developer: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested developer' do
      developer = Developer.create! valid_attributes
      expect {
        delete :destroy, params: {id: developer.to_param}, session: valid_session
      }.to change(Developer, :count).by(-1)
    end
  end

end
