require "zeitwerk"

require "oversee/version"
require "oversee/engine"

require "phlex-rails"
require "pagy"

# Zeitwerk
loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/generators")
loader.setup

module Oversee
  class << self
    def allowed_resource_list
      ApplicationRecord.descendants
    end
  end
end
