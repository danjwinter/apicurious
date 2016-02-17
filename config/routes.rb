Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  root 'home#show'
  delete '/logout', to: 'sessions#destroy'
  get  '/dashboard', to: 'dashboard#show'
end
