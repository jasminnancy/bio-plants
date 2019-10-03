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

  get "/plants/new", to: "plants#index"
  get "/plants/:id/water", to: "plants#water"
  get "/plants/:id/feed", to: "plants#feed"
  get "/plants/:id/sun", to: "plants#sun"

  get "/users/:id/add-friend", to: "friend_requests#create"
  get "/users/:id/remove-friend", to: "friendships#destroy"
  
  get "/friendships/:id/accept-request", to: "friend_requests#update"
  get "friendships/:id/deny-request", to: "friend_requests#destroy"
  get "friendships/:id/destroy", to: "friendships#destroy"
end
