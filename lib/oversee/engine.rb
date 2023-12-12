module Oversee
  class Engine < ::Rails::Engine
    isolate_namespace Oversee

    config.to_prepare do
      # Eager-loading to fetch all resources
      Rails.application.eager_load!
    end
  end
end
