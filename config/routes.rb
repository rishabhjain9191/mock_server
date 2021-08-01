Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  jsonapi_resources :endpoints
  # Handle user created paths
  get '*path', to: 'endpoints#handle'
  post '*path', to: 'endpoints#handle'
  patch '*path', to: 'endpoints#handle'
  delete '*path', to: 'endpoints#handle'
end
