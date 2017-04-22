Rails.application.routes.draw do
  post 'alexa', to: 'alexa#index'
  resources :talks
  root to: 'visitors#index'
end
