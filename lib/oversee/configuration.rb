# frozen_string_literal: true

module Oversee
  class Configuration

    attr_accessor :excluded_resources
    attr_accessor :filter_sensitive_columns

    def initialize
      @excluded_resources = []
      @filter_sensitive_columns = true
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
