Rails.application.routes.draw do
  require 'sidekiq/web'
  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'
 end

 
  resources :rooms do
    resource :room_user
    resources :messages
  end
  
  get '/technew', to: "stories#top"
  root to: "landing_page#index"
end
