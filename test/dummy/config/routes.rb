Rails.application.routes.draw do
  mount Oversee::Engine => "/oversee"

  root to: "dashboard#index"
end
