Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :goals, only: [:index, :new, :create, :show]
  resource :session, only: [:destroy, :new, :create]
end
