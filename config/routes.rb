Oversee::Engine.routes.draw do
  # Resources
  scope :resources, controller: "resources" do
    get ":resource_class_name/", action: :index, as: :resources
    get ":resource_class_name/new", action: :new, as: :new_resource
    post ":resource_class_name/", action: :create, as: :create_resource
    get ":resource_class_name/:id", action: :show, as: :resource
    get ":resource_class_name/:id/edit", action: :edit, as: :edit_resource
    patch ":resource_class_name/:id", action: :update, as: :update_resource
    delete ":resource_class_name/:id", action: :destroy, as: :destroy_resource
    get ":resource_class_name/:id/input_field", action: :input_field, as: :resource_input_field
  end

  root to: "dashboard#index"
end
