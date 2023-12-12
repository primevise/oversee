Oversee::Engine.routes.draw do

  # Resources
  resources :resources, only: [:index, :show]
  
  root to: "dashboard#show"
end
