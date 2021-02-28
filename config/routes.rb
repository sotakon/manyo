Rails.application.routes.draw do
  resources :tasks
  root to: 'tasks#index'
  resources :products, only: :show do
    collection do
      get 'search'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
