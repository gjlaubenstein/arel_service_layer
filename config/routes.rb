Rails.application.routes.draw do
  resources :pets
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/products', to: 'products#index'
  get '/products/:name', to: 'products#show'
  put '/products/:name', to: 'products#update'
  post '/products', to: 'products#create'
end
