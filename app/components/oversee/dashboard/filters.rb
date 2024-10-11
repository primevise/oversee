class Oversee::Dashboard::Filters < Oversee::Base
  def initialize(params: nil)
    @params = params
  end

  def view_template(&)
    div(class: "border-b p-4") do
      div(class: "flex items-center justify-between") do
        div(class: "flex items-center gap-4") do
          if show_action_section?
            button(class:"rounded-full bg-gray-100 inline-flex gap-2 items-center text-xs px-4 py-2 font-medium hover:bg-gray-200") do
              filter_icon
              plain "Filters"
            end
          end
        end
        div(class: "flex items-center gap-4") do
          form(action: "") do
            input(type: :search, name: :query, class: "block bg-gray-100 pl-6 py-2 placeholder:text-gray-500 rounded-sm", placeholder: "Search...", value: @params[:query])
          end
        end
      end
    end
  end

  private

  def show_action_section?
    Rails.env.development? || params[:experimental] == "true"
  end

  def filter_icon
    svg(
      stroke_width: "2",
      viewbox: "0 0 24 24",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      color: "currentColor",
      class: "size-3"
    ) do |s|
      s.path(
        d:
          "M2.99997 7V4C2.99997 3.44772 3.44769 3 3.99997 3H20.0001C20.5523 3 21 3.44766 21.0001 3.9999L21.0004 7M2.99997 7L9.65077 12.7007C9.87241 12.8907 9.99998 13.168 9.99998 13.4599V19.7192C9.99998 20.3698 10.6114 20.8472 11.2425 20.6894L13.2425 20.1894C13.6877 20.0781 14 19.6781 14 19.2192V13.46C14 13.168 14.1275 12.8907 14.3492 12.7007L21.0004 7M2.99997 7H21.0004",
        stroke: "currentColor",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end
 end
