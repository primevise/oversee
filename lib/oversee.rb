require "oversee/version"
require "oversee/engine"

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
