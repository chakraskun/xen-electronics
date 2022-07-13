Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # /api/v1/authentications
  namespace :api, defaults: {format: :hash} do
    post '/auth/login', to: 'authentication#login'
    get 'categories', to: 'categories#index'
    get 'products', to: 'products#index'
    get 'carts', to: 'carts#index'
    post 'carts/add', to: 'carts#add_item'
    post 'carts/deduct', to: 'carts#deduct_item'
    delete 'carts/checkout', to: 'carts#checkout'
  end
end
