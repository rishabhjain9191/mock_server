Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  jsonapi_resources :endpoints
  get '*path', to: 'mocks#handle'
end
