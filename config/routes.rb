Rails.application.routes.draw do
  root to: "home#index"
  resources :lots, only: [:index, :show]
end
