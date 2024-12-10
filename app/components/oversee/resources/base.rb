# frozen_string_literal: true

class Oversee::Resources::Base < Oversee::Base
  attr_reader :resource

  def initialize(resource:)
    @resource = resource
  end
end
