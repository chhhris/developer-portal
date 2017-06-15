require 'rails_helper'

RSpec.describe Api::V1::TokensController, type: :controller do
  render_views

  let!(:developer) { FactoryGirl.create(:developer, email: 'foo@bar.net', password: 'foobaz') }
  let(:json) { JSON.parse(response.body) }

  before {
    controller.class.skip_before_action :authenticate_developer!, raise: false
    allow(controller).to receive(:current_user) { developer }
  }

  describe 'GET #index' do
    it 'returns authentication token' do
      get :index, params: { email: 'foo@bar.net', password: 'foobaz' }
      expect(response).to be_success
      expect(json['data']['access_key']).to eq(developer.authentication_token)
    end
  end
end