Rails.application.routes.draw do
  devise_for :users
  root "wheels#index"
  resources :wheels, except: [:edit] do
    member do
      post :temp_create
      post :temp_delete
    end
  end
end
