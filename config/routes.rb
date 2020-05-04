Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'
  get '/about', to:'static_pages#about'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
 resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create,:destroy]
  resources :posts
  
end
