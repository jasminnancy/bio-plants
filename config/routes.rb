Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :plants, except: [:delete]
  resources :friendships
  
  get "/", to: 'users#home'
  get "/messages", to: 'users#comingsoon'
  get "/error", to: 'layouts#error_page'

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#logout"
end
