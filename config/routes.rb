Rails.application.routes.draw do
  root to: 'toppages#index'
  
  resources :hotels, only: [:new]
  resources :middle_classes, only: [:new]
  resources :small_classes, only: [:new]
  resources :detail_classes, only: [:new]
end
