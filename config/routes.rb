Rails.application.routes.draw do
  resources :sessions
  resources :users
  resources :posts
end
