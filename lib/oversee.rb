require "zeitwerk"

require "oversee/version"
require "oversee/engine"

require "phlex-rails"
# require_relative "test_component"

loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/generators")
loader.setup

module Oversee
  class << self
    def resource_list
      ApplicationRecord.descendants
    end

    def foobar(klass)
      klass
    end
  end
end
