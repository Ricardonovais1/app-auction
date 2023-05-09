Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :lots, only: [:index, :show, :new, :create] do 
    get 'expired', on: :collection
  end
  resources :product_categories, only: [:new, :create]
  resources :items, only: [:index, :new, :create, :show]
end
