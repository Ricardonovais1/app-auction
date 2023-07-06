# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :lots, only: %i[index show new create edit update] do
    resources :questions, only: %i[new create show] do
      post 'block_by_cpf', on: :member
      resources :answers, only: %i[new create]
      get 'hidden', on: :member
      get 'visible', on: :member
    end
    resources :favorites, only: %i[create destroy]
    resources :bids, only: %i[new create]
    resources :lot_items, only: %i[new create destroy] do
      delete 'remove', on: :member
    end
    get 'expired', on: :collection
    post 'approved', on: :member
    get 'pending', on: :collection
    post 'pending_approval', on: :member
    get 'successfull_bids', on: :collection
    post 'bid_on_lot', on: :member
  end

  resources :product_categories, only: %i[index new create]

  resources :items, only: %i[index new create show edit update] do
    get 'search', on: :collection
  end

  resources :blocked_cpfs, only: %i[index new create]

  resources :users, only: %i[show edit update]

  namespace :api do
    namespace :v1 do
      resources :lots, only: %i[show index create update destroy]
    end
  end
end
