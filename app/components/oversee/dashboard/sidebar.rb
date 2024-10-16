# frozen_string_literal: true

class Oversee::Dashboard::Sidebar < Oversee::Base
  def view_template
    div(class: "bg-white p-4 rounded-lg") do
      button(class: "mb-4 ") { collapse_icon } unless true

      p(class: "text-[0.7rem] uppercase text-gray-400 font-medium mb-2") { "Menu" }
      ul(class: "text-sm text-gray-700") do
        li do
          a(href: root_path, class:"flex items-center gap-2 hover:bg-gray-50 p-2") do
            render Phlex::Icons::Iconoir::LayoutLeft.new(class: "size-4 text-gray-400")
            span { "Dashboard" }
          end
        end
        li do
          a(href: helpers.main_app.root_path, class: "flex items-center gap-2 hover:bg-gray-50 p-2 rounded-lg") do
            render Phlex::Icons::Iconoir::HomeAltSlimHoriz.new(class: "size-4 text-gray-400")
            span { "Return to app" }
          end
        end
      end

      hr(class: "my-4 -mx-4")
      details(open: true, class: "group") do
        summary(class: "flex items-center justify-between cursor-pointer") do
          p(class: "text-[0.7rem] uppercase text-gray-400 font-medium") { "Resources" }
          render Phlex::Icons::Iconoir::NavArrowDown.new(class: "size-4 text-gray-400 transform transition-transform group-open:rotate-180 group-hover:text-blue-500")
        end
        ul(class: "mt-2 text-sm text-gray-700 overflow-x-hidden") do
          Oversee.application_resource_names.sort.each do |resource_class_name|
            li do
              a(href: helpers.resources_path(resource_class_name:), class: "flex items-center gap-2 hover:bg-gray-50 p-2 truncate") do
                render Phlex::Icons::Iconoir::Folder.new(class: "size-4 text-gray-400")
                span { resource_class_name }
              end
            end
          end
        end
      end

      hr(class: "my-4 -mx-4")
      p(class: "text-xs text-gray-500") do
        plain("Powered by ")
        a(
            href: "https://github.com/primevise/oversee",
            class: "text-blue-500 hover:underline",
            target: "_blank"
          ) { "Oversee" }
      end
    end
  end
end
