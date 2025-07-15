# frozen_string_literal: true

module Oversee
  class Configuration
    # Attributes
    attr_accessor :excluded_resources
    attr_accessor :filter_sensitive_columns
    attr_accessor :sensitive_column_titles
    attr_accessor :per_page

    def initialize
      @excluded_resources = []
      @filter_sensitive_columns = true
      @sensitive_column_titles = %w[password password_digest access_token]
      @per_page = 16
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
