Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :goals
  resource :session, only: [:destroy, :new, :create]
end
