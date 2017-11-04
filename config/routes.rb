Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'overrides/registrations',
    sessions: 'overrides/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :users, only: [:show], path: '/profile'
  resources :projects, only: [:create, :index, :update]
  resources :offers, only: [:create]
  resources :technologies, only: [:index]
end
