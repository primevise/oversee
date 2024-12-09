Rails.application.routes.draw do
  mount Oversee::Engine => "/"

  root to: "dashboard#index"
end
