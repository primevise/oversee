require "zeitwerk"

require "oversee/version"
require "oversee/engine"
require "oversee/configuration"

require "phlex-rails"
require "pagy"

# Zeitwerk
loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/generators")
loader.setup

module Oversee
  class << self

    def application_name
      Rails.application.class.to_s.gsub("::Application", "")
    end

    def filtered_resources
      ApplicationRecord
        .descendants
        .filter { |klass| !configuration.excluded_resources.include?(klass.to_s) }
    end

    def application_resource_names
      filtered_resources.map(&:to_s).sort
    end

    def card_class_names
      root = Rails.root.join("app/oversee/cards/")
      files = Dir.glob(root.join("**/*.rb"))
      files.map! { |f| f.split(root.to_s).last.delete_suffix(".rb").classify.prepend("Cards::") }
    end
  end
end
