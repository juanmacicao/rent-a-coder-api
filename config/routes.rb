Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'overrides/registrations',
    sessions: 'overrides/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show]
  resource :users, only: [:update]
  get '/profile', to: 'users#profile'
  resources :projects, only: [:create, :index, :update, :show] do
    post 'developer', to: 'projects#assign_developer'
    post 'developer_score', to: 'projects#set_developer_score'
    post 'owner_score', to: 'projects#set_owner_score'
  end
  resources :offers, only: [:create]
  resources :technologies, only: [:index]
  resources :candidates, only: [:show]
end
