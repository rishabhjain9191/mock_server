Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  jsonapi_resources :endpoints
  # In case, we are getting blank ids, route to endpoints controller
  patch '/endpoints/', to: 'endpoints#update'
  delete '/endpoints/', to: 'endpoints#destroy'
  # Handle user created paths
  get '*path', to: 'mocks#handle'
  post '*path', to: 'mocks#handle'
  patch '*path', to: 'mocks#handle'
  delete '*path', to: 'mocks#handle'
end
