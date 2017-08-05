Rails.application.routes.draw do
  # devise routes
  devise_for :users

  # my routes
  get 'home/index'
  root 'home#index'

  # items routes
  get '/items/:id', to: 'items#show'

  # favorites routes
  post '/favourites', to: 'favourites#create'
  get '/favourites', to: 'favourites#index'
  get '/favourites/:id', to: 'favourites#show'
  delete '/favourites', to: 'favourites#destroy'

  # user activity routes
  get '/user_activity', to: 'user_activity#index'
end
