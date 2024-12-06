class Oversee::Dashboard::Header < Oversee::Base
  attr_reader :title
  attr_reader :subtitle
  attr_reader :return_path
  attr_reader :show_back_button

  def initialize(title: nil, subtitle: nil, return_path: nil, show_back_button: true)
    @title = title || "Dashboard"
    @subtitle = subtitle || "Manage your account"
    @return_path = return_path
    @show_back_button = show_back_button
  end

  def view_template(&)

    div(class: "min-h-10 flex items-center justify-between") do
      if block_given?
        yield(self)
      else
        left
        right
      end
    end
  end

  def left(&)
    div(class: "flex items-center gap-2") do
      back_button if show_back_button
      h3(class: "text-lg font-medium text-gray-900") { title } if title.present?
      yield if block_given?
    end
  end

  def right(&)
    div(class: "flex items-center gap-4", &)
  end

  def separator
    render Phlex::Icons::Iconoir::Slash.new(class: "size-4 text-gray-300", stroke_width: 1.75)
  end

  private

  def back_button
    a(
      href: return_button_path,
      class: "mr-2 size-8 inline-flex items-center justify-center bg-gray-50 text-gray-500 hover:text-gray-900 hover:bg-gray-200 transition-colors",
      data: { controller: "back", action: "back#navigate", turbo_action: "replace" }
    ) do
      render Phlex::Icons::Iconoir::ArrowLeft.new(class: "size-3", stroke_width: 2.5)
    end
  end

  def return_button_path
    @return_path || root_path
  end
end
