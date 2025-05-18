class Oversee::Views::Base < Oversee::Components::Base
  def around_template
    render Oversee::Components::Layout::Application.new { super }
  end
end
