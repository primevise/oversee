class Oversee::Views::Base < Phlex::HTML
  def around_template
    render Oversee::Layout::Application.new { super }
  end
end
