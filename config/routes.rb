Rails.application.routes.draw do
  root 'wall#index'
  get '/wall', to: 'wall#index'
  post '/wall', to: 'wall#create', as: :walls
end
