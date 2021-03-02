Rails.application.routes.draw do
  get 'sessions/new'
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'tasks#index'
  namespace :admin do
    resources :users
  end
  resources :products, only: :show do
    collection do
      get 'search'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
