Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  get 'middle_classes', to: 'areas#middle_classes'
  get 'small_classes/:id', to: 'areas#small_classes'
  get 'detail_classes/:id', to: 'areas#detail_classes'
  
  resources :users, only: [:show, :new, :create]
  resources :hotels, only: [:new]
  resources :favorites, only: [:create, :destroy]
end
