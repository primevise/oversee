Oversee::Engine.routes.draw do

  # Resources
  resources :resources do
    resources :fields, only: [:show, :edit, :update]
    get :input_field, on: :member
  end
  
  root to: "dashboard#show"
end
