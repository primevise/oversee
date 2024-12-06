class Oversee::Dashboard::Filters < Oversee::Base
  def initialize(params: nil)

    @params = params

    puts "params: #{params}"
    puts "sortless_path: #{sortless_path}"
  end

  def view_template(&)
    div(class: "flex items-center justify-between") do
      div(class: "flex items-center gap-2") do
        if show_action_section?
          button(class:"rounded-full bg-gray-100 inline-flex gap-2 items-center text-xs px-4 py-2 font-medium hover:bg-gray-200") do
            render Phlex::Icons::Iconoir::FilterAlt.new(class: "size-3")
            plain "Filters"
          end
        end
        if false
          a(class:"rounded-full bg-gray-100 inline-flex gap-2 items-center text-xs px-4 py-2 font-medium hover:bg-gray-200") do
            render Phlex::Icons::Iconoir::XMark.new(class: "size-4 text-gray-500")
            plain "Clear sorting"
          end
        end
      end
      div(class: "flex items-center gap-4") do
        form(action: "", class: "flex items-center gap-2") do
          input(
            type: :search,
            name: :query,
            value: @params[:query],
            placeholder: search_placeholder,
            class: "flex bg-gray-100 min-w-64 w-64 focus:w-96 transition-all h-10 items-center pl-4 py-2 placeholder:text-gray-500 rounded-sm text-sm"
          )
          button(class: "size-10 inline-flex items-center justify-center bg-gray-100 hover:bg-gray-200 transition-colors") { render Phlex::Icons::Iconoir::Search.new(class: "size-4 text-gray-600") }
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
    context = Oversee::Search.new(collection: nil, resource_class: @params[:resource_class_name].constantize)
    attr = context.default_searchable_attribute

    "Search by #{attr}"
  end
 end
