class Oversee::Dashboard::Header < Oversee::Base
  def initialize(title: nil, subtitle: nil, return_path: nil, show_back_button: true)
    @title = title || "Dashboard"
    @subtitle = subtitle || "Manage your account"
    @return_path = return_path
    @show_back_button = show_back_button
  end

  def view_template(&)
    div(class: "p-6 border-b flex items-center justify-between") do
      div(class: "flex items-center gap-4") do
        back_button
        div do
          h1(class: "text-xl text-gray-800") { @title }
          p(class: "text-sm text-gray-600") { @subtitle }
        end
      end
      div(class: "flex items-center gap-2") do
        yield if block_given?
      end
    end
  end

  private

  def back_button
    if @show_back_button
      a(href: return_button_path, class: "size-10 inline-flex items-center justify-center bg-gray-50 text-gray-500 hover:text-gray-900 hover:bg-gray-200 transition-colors", data: { controller: "back", action: "back#navigate", turbo_action: "replace" }) do
        # render Phlex::TablerIcons::ArrowLeft.new(class: "size-5 ")
        plain "<-"
      end
    end
  end

  def return_button_path
    @return_path || dashboard_path
  end
end
