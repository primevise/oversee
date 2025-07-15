# frozen_string_literal: true

class Oversee::Components::TurboFrame < Components::Base
  register_element :turbo_frame

  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template(&)
    turbo_frame(**@attributes, &)
  end
end
