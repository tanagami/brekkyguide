Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
  
  resources :hotels, only: [:new]
  resources :middle_classes, only: [:new]
  resources :small_classes, only: [:new]
  resources :detail_classes, only: [:new]
end
