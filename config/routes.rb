MyNsci::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }  do
    get 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  devise_scope :user do
    get 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :computers, except: [:show] do
    member do
      get :key
    end
    resources :visits, only: [:index, :update]
  end

  get '/check/:key' => 'computers#check', as: :check

  match '*path' => 'application#render_404', via: [:get, :post]
  root to: 'computers#index'
end
