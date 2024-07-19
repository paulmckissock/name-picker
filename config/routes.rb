Rails.application.routes.draw do
  devise_for :users
  root "wheels#index"
  resources :wheels, except: [:edit] do
    member do
      post :temp_create
      post :temp_delete
      post :sort_alphabetically
      post :shuffle
      post :reset_participants
    end
  end
  
  resources :results, only: [:create]
end
