Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  post "/reply", to: 'chat#reply'
  get "/counts", to: 'metrics#counts'
  get "/contents", to: 'metrics#contents'
  get "/links", to: 'metrics#links'
end
