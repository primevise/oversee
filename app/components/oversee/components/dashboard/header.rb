class Oversee::Components::Dashboard::Header < Oversee::Components::Base
  attr_reader :subtitle
  attr_reader :return_path
  attr_reader :show_back_button

  def initialize(return_path: nil, show_back_button: true)
    @return_path = return_path
    @show_back_button = show_back_button
  end

  def view_template(&)
    div(class: "flex items-center justify-between gap-4 py-4 md:py-0 md:h-16 border-b border-gray-100 px-4") do
      yield if block_given?
    end
  end


  def item(**mattributes, &)
    mattributes[:class] = "flex items-center gap-2"
    div(**mattributes, &)
  end

  def title(&)
    render Oversee::Components::Heading.new(as: :h6, &)
  end

  # def icon(**mattributes, &)
  #   render Phlex::Icons::Iconoir::Icon.new(**mattributes, &)
  # end

  # def left(&)
  #   div(class: "flex items-center gap-1") do
  #     back_button if show_back_button
  #     render Heading.new(as: :h6) { title } if title.present?
  #     yield if block_given?
  #   end
  # end

  # def right(&)
  #   div(class: "flex items-center gap-4", &)
  # end

  def separator
    render Phlex::Icons::Iconoir::Slash.new(class: "size-4 text-gray-300", stroke_width: 1.75)
  end

  private

  def back_button
    render Button.new(
      href: return_button_path,
      kind: :secondary,
      size: :none,
      class: "mr-2 justify-center size-6",
      data: { controller: "back", action: "back#navigate", turbo_action: "replace" }
    ) do
      render Phlex::Icons::Iconoir::ArrowLeft.new(class: "size-2.5", stroke_width: 2.5)
    end
  end

  def return_button_path
    return_path || dashboard_path
  end







  # attr_reader :title
  # attr_reader :subtitle
  # attr_reader :return_path
  # attr_reader :show_back_button

  # def initialize(title: nil, subtitle: nil, return_path: nil, show_back_button: true)
  #   @title = title || "Dashboard"
  #   @subtitle = subtitle || "Manage your account"
  #   @return_path = return_path
  #   @show_back_button = show_back_button
  # end

  # def view_template(&)

  #   div(class: "h-12 flex items-center justify-between px-4") do
  #     if block_given?
  #       yield(self)
  #     else
  #       left
  #       right
  #     end
  #   end
  # end

  # def left(&)
  #   div(class: "flex items-center gap-2") do
  #     back_button if show_back_button
  #     h3(class: "text-lg font-medium text-gray-900") { title } if title.present?
  #     yield if block_given?
  #   end
  # end

  # def right(&)
  #   div(class: "flex items-center gap-4", &)
  # end

  # def separator
  #   render Phlex::Icons::Iconoir::Slash.new(class: "size-4 text-gray-300", stroke_width: 1.75)
  # end

  # private

  # def back_button
  #   a(
  #     href: return_button_path,
  #     class: "mr-2 size-8 inline-flex items-center justify-center bg-gray-50 text-gray-500 hover:text-gray-900 hover:bg-gray-200 transition-colors",
  #     data: { controller: "back", action: "back#navigate", turbo_action: "replace" }
  #   ) do
  #     render Phlex::Icons::Iconoir::ArrowLeft.new(class: "size-3", stroke_width: 2.5)
  #   end
  # end

  # def return_button_path
  #   @return_path || root_path
  # end
end
