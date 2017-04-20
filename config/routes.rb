Rails.application.routes.draw do
  resources :talks
  root to: 'visitors#index'
end
