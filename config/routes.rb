Oversee::Engine.routes.draw do

  # Resources
  resources :resources
  
  root to: "dashboard#show"
end
