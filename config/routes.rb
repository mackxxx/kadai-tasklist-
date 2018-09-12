Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'users/index'

  get 'users/show'

  get 'users/new'

  get 'users/create'

  root to: 'tasks#index'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
end