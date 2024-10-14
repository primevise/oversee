class Oversee::Dashboard::Filters < Oversee::Base
  def initialize(params: nil)

    @params = params

    puts "params: #{params}"
    puts "sortless_path: #{sortless_path}"
  end

  def view_template(&)
    div(class: "border-b p-4") do
      div(class: "flex items-center justify-between") do
        div(class: "flex items-center gap-2") do
          if show_action_section?
            button(class:"rounded-full bg-gray-100 inline-flex gap-2 items-center text-xs px-4 py-2 font-medium hover:bg-gray-200") do
              filter_icon
              plain "Filters"
            end
          end
          if false
            a(class:"rounded-full bg-gray-100 inline-flex gap-2 items-center text-xs px-4 py-2 font-medium hover:bg-gray-200") do
              x_icon
              plain "Clear sorting"
            end
          end
        end
        div(class: "flex items-center gap-4") do
          form(action: "", class: "flex items-center gap-2") do
            input(type: :search, name: :query, class: "flex bg-gray-100 min-w-80 h-10 items-center pl-4 py-2 placeholder:text-gray-500 rounded-sm text-sm", placeholder: search_placeholder, value: @params[:query])
            button(class: "size-10 inline-flex items-center justify-center bg-gray-100 hover:bg-gray-200 transition-colors") { search_icon }
          end
        end
      end
    end
  end

  private

  def show_action_section?
    Rails.env.development? || @params[:experimental] == "true"
  end

  def sortless_path
    sortless_query_params = @params.except(:sort_attribute, :sort_direction, :controller, :action)
    # helpers.resources_path(sortless_query_params)
  end

  def search_placeholder
    context = Search.new(collection: nil, resource_class: @params[:resource_class_name].constantize)
    attr = context.default_searchable_attribute

    "Search by #{attr}"
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

  def search_icon
    svg(
      viewbox: "0 0 24 24",
      stroke_width: "2",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      color: "currentColor",
      class: "size-4 text-gray-700"
    ) do |s|
      s.path(
        d: "M17 17L21 21",
        stroke: "currentColor",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
      s.path(
        d:
          "M3 11C3 15.4183 6.58172 19 11 19C13.213 19 15.2161 18.1015 16.6644 16.6493C18.1077 15.2022 19 13.2053 19 11C19 6.58172 15.4183 3 11 3C6.58172 3 3 6.58172 3 11Z",
        stroke: "currentColor",
        stroke_width: "1.5",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end

  def x_icon
    svg(
      stroke_width: "2",
      viewbox: "0 0 24 24",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      color: "currentColor",
      class: "size-4 text-gray-500"
    ) do |s|
      s.path(
        d:
          "M6.75827 17.2426L12.0009 12M17.2435 6.75736L12.0009 12M12.0009 12L6.75827 6.75736M12.0009 12L17.2435 17.2426",
        stroke: "currentColor",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end
 end
