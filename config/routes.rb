Rails.application.routes.draw do
  root 'home#show'
  get '/dashboard', to: 'dashboard#show'
  #o-auth
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/auth/:provider/callback', to: 'sessions#destroy'
end
