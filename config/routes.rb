Rails.application.routes.draw do
  root to: 'toppages#index'
  
  resources :hotels, only: [:new]
end
