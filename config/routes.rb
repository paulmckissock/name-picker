Rails.application.routes.draw do
  devise_for :users
  root "wheels#index"
  resources :wheels, except: [:edit] do
    member do
      post :temp_create
      post :temp_delete
      post :sort_alphabetically
      post :shuffle
    end
  end
end
