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
      a(
        href: return_button_path,
        class: "size-10 inline-flex items-center justify-center bg-gray-50 text-gray-500 hover:text-gray-900 hover:bg-gray-200 transition-colors",
        data: { controller: "back", action: "back#navigate", turbo_action: "replace" }
      ) do
        back_icon
      end
    end
  end

  def return_button_path
    @return_path || dashboard_path
  end

  def back_icon
    svg(
      viewbox: "0 0 24 24",
      stroke_width: "2",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      color: "currentColor",
      class: "size-4"
    ) do |s|
      s.path(
        d: "M21 12L3 12M3 12L11.5 3.5M3 12L11.5 20.5",
        stroke: "#000000",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end
end
