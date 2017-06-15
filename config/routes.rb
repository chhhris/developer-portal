Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :developers
      resources :tokens, only: :index
      resources :applications
    end
  end

  match '/404', :to => 'errors#not_found', :via => :all
  match '/500', :to => 'errors#exception', :via => :all
end
