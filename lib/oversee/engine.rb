require "importmap-rails"

module Oversee
  class Engine < ::Rails::Engine
    isolate_namespace Oversee

    config.to_prepare do
      # Eager-loading to fetch all resources
      Rails.application.eager_load!
    end

    initializer "oversee.autoloaders" do |app|
      Rails.autoloaders.main.push_dir(
        File.join(Oversee.root_path, "app", "views", "oversee"),
        namespace: Oversee::Views
      )
    end

    initializer "oversee.assets" do |app|
      if app.config.respond_to?(:assets)
        app.config.assets.paths << root.join("app/javascript")
        app.config.assets.precompile += %w[oversee_manifest]
      end
    end

    initializer "oversee.importmap", before: "importmap" do |app|
      Oversee.importmap.draw root.join("config/importmap.rb")
      Oversee.importmap.cache_sweeper watches: root.join("app/javascript")

      ActiveSupport.on_load(:action_controller_base) do
        before_action { Oversee.importmap.cache_sweeper.execute_if_updated }
      end
    end
  end
end
