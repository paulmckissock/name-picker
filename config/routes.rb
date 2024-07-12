Rails.application.routes.draw do
  root "wheels#index"
  resources :wheels do
    member do
      post :temp_create
      post :temp_delete
    end
  end
end
