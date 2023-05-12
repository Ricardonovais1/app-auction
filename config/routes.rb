Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :lots, only: [:index, :show, :new, :create] do 
    resources :lot_items, only: [:new, :create, :destroy] do 
      delete 'remove', on: :member
    end
    get 'expired', on: :collection
    post 'approved', on: :member
    get 'pending', on: :collection
    post 'pending_approval', on: :member
  end
  resources :product_categories, only: [:new, :create]
  resources :items, only: [:index, :new, :create, :show]
end
