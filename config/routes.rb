Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  get 'show_middle', to: 'areas#show_middle'
  get 'show_small/:id', to: 'areas#show_small'
  get 'show_detail/:id', to: 'areas#show_detail'
  
  resources :users, only: [:show, :new, :create]
  resources :hotels, only: [:new, :show]
  resources :favorites, only: [:create, :destroy]
end
