Rails.application.routes.draw do
  resources :sessions
  resources :users do
    member do
      get 'toFollow'
    end
  end
  resources :posts
end
