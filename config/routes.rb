Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :lots, only: [:index, :show, :new, :create, :edit, :update] do 
    resources :questions, only: [:new, :create, :show] do 
      post 'block_by_cpf', on: :member
      resources :answers, only: [:new, :create]
      get 'hidden', on: :member
      get 'visible', on: :member
    end
    resources :bids, only: [:new, :create] 
    resources :lot_items, only: [:new, :create, :destroy] do 
      delete 'remove', on: :member
    end
    get 'expired', on: :collection
    post 'approved', on: :member
    get 'pending', on: :collection
    post 'pending_approval', on: :member
    get 'successfull_bids', on: :collection
    post 'bid_on_lot', on: :member
  end
  resources :product_categories, only: [:new, :create]
  resources :items, only: [:index, :new, :create, :show, :edit, :update] do 
    get 'search', on: :collection
  end
  resources :blocked_cpfs, only: [:new, :create] 
  resources :users, only: [:show, :edit, :update]
end
