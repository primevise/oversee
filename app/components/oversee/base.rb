class Oversee::Base < Phlex::HTML
  include Phlex::Rails::Helpers::DOMID
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::LinkTo

  RESOURCE_PATHS = [
    :resources_path,
    :resource_path,
    :new_resource_path,
    :create_resource_path,
    :update_resource_path,
    :destroy_resource_path,
    :resource_input_path,
    :resources_table_path
  ]

  RESOURCE_PATHS.each do |path_helper|
    register_value_helper path_helper
  end
end
