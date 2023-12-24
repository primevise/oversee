Oversee::Engine.routes.draw do

  # Resources
  resources :resources do
    get :input_field, on: :member
  end
  
  root to: "dashboard#show"
end
