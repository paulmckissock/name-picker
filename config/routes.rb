Rails.application.routes.draw do
  root "wheels#index"
  resources :wheels do
    member do
      post :temp_create
      post :temp_delete
      patch :save
    end
  end

  get "/wheels/:id", to: "wheels#show"
  get "/wheels/:id/edit", to: "wheels#edit"
end
