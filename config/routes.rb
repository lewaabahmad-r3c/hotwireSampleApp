Rails.application.routes.draw do
  get 'cart_items/create'
  get 'cart_items/update'
  get 'cart_items/destroy'
  get 'carts/show'
  get 'products/index'
  get 'products/show'
  # devise_for :users, controllers: { registrations: 'registrations' }

  resources :products, only: %i[index show]
  resources :cart_items, only: %i[index create update destroy]

  root 'products#index'

  get 'search', to: 'pages#search'
end
