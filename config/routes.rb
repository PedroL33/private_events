Rails.application.routes.draw do
  root 'users#index'
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/login', to: 'sessions#destroy'
  resources :users
  resources :events, only: [:show, :index, :create, :new]
  resources :event_attendees, only: [:create, :destroy, :new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
