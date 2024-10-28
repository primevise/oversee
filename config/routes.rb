Oversee::Engine.routes.draw do
  # Resources
  scope ":resource_class_name", controller: "resources" do
    get "/", action: :index, as: :resources
    post "/", action: :create, as: :create_resource
    get "/:id", action: :show, as: :resource
    get "/:id/edit", action: :edit, as: :edit_resource
    patch "/:id", action: :update, as: :update_resource
    delete "/:id", action: :destroy, as: :destroy_resource
    get "/table", action: :table, as: :resources_table
    get "/new", action: :new, as: :new_resource

    get "/:id/input_field", action: :input_field, as: :resource_input_field
    get "/:id/association", action: :association, as: :resource_association


    # To reach this route using Rails' route helpers, use resource_input_path(:resource_class_name, :id)
    get "/:id/input", controller: "resources/fields", action: :input, as: :resource_input
  end

  root to: "dashboard#index"
end
