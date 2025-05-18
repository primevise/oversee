# frozen_string_literal: true

class Oversee::Components::Dashboard::Sidebar < Oversee::Components::Base
  def view_template
    div(class: "bg-white min-h-svh p-4") do
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
          a(href: main_app.root_path, class: "flex items-center gap-2 hover:bg-gray-50 p-2 rounded-lg") do
            render Phlex::Icons::Iconoir::HomeAltSlimHoriz.new(class: "size-4 text-gray-400")
            span { "Return to app" }
          end
        end
      end

      # render Oversee::Components::Separator.new(class: "my-4 -mx-4")

      hr(class: "my-4 -mx-4")

      p(class: "text-[0.7rem] uppercase text-gray-400 font-medium") { "Resources" }
      ul(class: "mt-2 text-sm text-gray-700 overflow-x-hidden") do
        Oversee.application_resource_names.sort.each do |resource|
          li do
            a(href: resources_path(resource:), class: "flex items-center gap-2 hover:bg-gray-50 p-2 truncate") do
              render Phlex::Icons::Iconoir::Folder.new(class: "size-4 text-gray-400")
              span { resource }
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
