# Zeitwerk
require "zeitwerk"

# Oversee
require "oversee/version"
require "oversee/engine"
require "oversee/configuration"

# Phlex
require "phlex-rails"

# Pagy
require "pagy"
require "pagy/extras/i18n"

# Zeitwerk
loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/generators")
loader.setup

module Oversee

  mattr_accessor :importmap, default: Importmap::Map.new

  class << self

    def root_path
      @root_path ||= Gem::Specification.find_by_name("oversee").gem_dir
    end

    def application_name
      @application_name ||= Rails.application.class.to_s.gsub("::Application", "")
    end

    # Resources
    def application_resources(filtered: true)
      resources = ::ApplicationRecord.descendants
      resources = resources.filter { |klass| !Oversee.configuration.excluded_resources.include?(klass.to_s) } if filtered
    end

    def application_resource_names(filtered: true)
      application_resources(filtered:).map(&:to_s)
    end

    # Cards
    def card_class_names
      root = Rails.root.join("app/oversee/cards/")
      files = Dir.glob(root.join("**/*.rb"))
      files.map! { |f| f.split(root.to_s).last.delete_suffix(".rb").classify.prepend("Cards::") }
    end
  end

  # Phlex configuration
  module Views
  end
end
