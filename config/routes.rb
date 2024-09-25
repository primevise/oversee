Oversee::Engine.routes.draw do

  # Resources
  scope :resources, controller: "resources" do
    get ":resource/", action: :index, as: :resources
    get ":resource/new", action: :new, as: :new_resource
    post ":resource_class/", action: :create, as: :create_resource
    get ":resource/:id", action: :show, as: :resource
    get ":resource/:id/edit", action: :edit, as: :edit_resource
    patch ":resource/:id", action: :update, as: :update_resource
    delete ":resource/:id", action: :destroy, as: :destroy_resource
    get ":resource/:id/input_field", action: :input_field, as: :input_field
  end

  root to: "dashboard#show"
end
