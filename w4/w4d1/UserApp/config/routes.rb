Rails.application.routes.draw do
  resources :users, only: [:index, :create, :show, :update, :destroy] do
    resources :contacts, only: [:index]
    resources :comments, only: [:index]
  end
  resources :contacts, only: [:create, :show, :update, :destroy] do
    resources :comments, only: [:index]
  end
  resources :contact_shares, only: [:create, :destroy]
end
