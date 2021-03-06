require 'rails_helper'

RSpec.describe Api::V1::DevelopersController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/api/v1/developers').to route_to('api/v1/developers#index')
    end


    it 'routes to #show' do
      expect(:get => '/api/v1/developers/1').to route_to('api/v1/developers#show', :id => '1')
    end


    it 'routes to #create' do
      expect(:post => '/api/v1/developers').to route_to('api/v1/developers#create')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/api/v1/developers/1').to route_to('api/v1/developers#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/api/v1/developers/1').to route_to('api/v1/developers#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/api/v1/developers/1').to route_to('api/v1/developers#destroy', :id => '1')
    end

  end
end
