Rails.application.routes.draw do
  resources :labels
  get 'sessions/new'
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'tasks#index'
  namespace :admin do
    resources :users, only: [:index, :show, :new, :create, :destroy, :edit, :update]
  end
  resources :products, only: :show do
    collection do
      get 'search'
    end
  end
end
