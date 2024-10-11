# frozen_string_literal: true

class Oversee::Dashboard::Sidebar < Oversee::Base
  def view_template
    div(class: "bg-white p-4 rounded-lg") do
      button(class: "mb-4 ") { collapse_icon } unless true

      p(class: "text-[0.7rem] uppercase text-gray-400 font-medium mb-2") { "Menu" }
      ul(class: "text-sm text-gray-700") do
        li do
          a(href: root_path, class:"flex items-center gap-2 hover:bg-gray-50 p-2") do
            layout_icon
            span { "Dashboard" }
          end
        end
        li do
          a(href: helpers.main_app.root_path, class: "flex items-center gap-2 hover:bg-gray-50 p-2 rounded-lg") do
            main_app_icon
            span { "Return to app" }
          end
        end
      end

      hr(class: "my-4 -mx-4")
      details(open: true, class: "group") do
        summary(class: "flex items-center justify-between cursor-pointer") do
          p(class: "text-[0.7rem] uppercase text-gray-400 font-medium") { "Resources" }
          caret_icon
        end
        ul(class: "mt-2 text-sm text-gray-700 overflow-x-hidden") do
          ApplicationRecord.descendants.map(&:to_s).sort.each do |resource_class_name|
            li do
              a(href: helpers.resources_path(resource_class_name:), class: "flex items-center gap-2 hover:bg-gray-50 p-2 truncate") do
                folder_icon
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

  private

  def collapse_icon
    svg(
      stroke_width: "1.5",
      viewbox: "0 0 24 24",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      color: "currentColor",
      class: "size-5"
    ) do |s|
      s.path(
        d:
          "M19 21L5 21C3.89543 21 3 20.1046 3 19L3 5C3 3.89543 3.89543 3 5 3L19 3C20.1046 3 21 3.89543 21 5L21 19C21 20.1046 20.1046 21 19 21Z",
        stroke: "currentColor",
        stroke_width: "1.5",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
      s.path(
        d: "M7.25 10L5.5 12L7.25 14",
        stroke: "currentColor",
        stroke_width: "1.5",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
      s.path(
        d: "M9.5 21V3",
        stroke: "currentColor",
        stroke_width: "1.5",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end

  def folder_icon
    svg(
      stroke_width: "2",
      viewbox: "0 0 24 24",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      color: "currentColor",
      class: "size-4 text-gray-400"

    ) do |s|
      s.path(
        d:
          "M2 11V4.6C2 4.26863 2.26863 4 2.6 4H8.77805C8.92127 4 9.05977 4.05124 9.16852 4.14445L12.3315 6.85555C12.4402 6.94876 12.5787 7 12.722 7H21.4C21.7314 7 22 7.26863 22 7.6V11M2 11V19.4C2 19.7314 2.26863 20 2.6 20H21.4C21.7314 20 22 19.7314 22 19.4V11M2 11H22",
        stroke: "currentColor",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end

  def main_app_icon
    svg(
      xmlns: "http://www.w3.org/2000/svg",
      width: "24",
      height: "24",
      viewbox: "0 0 24 24",
      fill: "none",
      stroke: "currentColor",
      stroke_width: "2",
      stroke_linecap: "round",
      stroke_linejoin: "round",
      class: "h-4 w-4 text-gray-400"
    ) do |s|
      s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
      s.path(d: "M9 21v-6a2 2 0 0 1 2 -2h2c.247 0 .484 .045 .702 .127")
      s.path(d: "M19 12h2l-9 -9l-9 9h2v7a2 2 0 0 0 2 2h5")
      s.path(d: "M16 22l5 -5")
      s.path(d: "M21 21.5v-4.5h-4.5")
    end
  end

  def layout_icon
    svg(
      xmlns: "http://www.w3.org/2000/svg",
      width: "24",
      height: "24",
      viewbox: "0 0 24 24",
      fill: "none",
      stroke: "currentColor",
      stroke_width: "2",
      stroke_linecap: "round",
      stroke_linejoin: "round",
      class: "h-4 w-4 text-gray-400"
    ) do |s|
      s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
      s.path(
        d:
          "M4 4m0 2a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v1a2 2 0 0 1 -2 2h-2a2 2 0 0 1 -2 -2z"
      )
      s.path(
        d:
          "M4 13m0 2a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v3a2 2 0 0 1 -2 2h-2a2 2 0 0 1 -2 -2z"
      )
      s.path(
        d:
          "M14 4m0 2a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-2a2 2 0 0 1 -2 -2z"
      )
    end
  end

  def caret_icon
    svg(
      stroke_width: "2",
      viewbox: "0 0 24 24",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      color: "currentColor",
      class: "size-4 text-gray-500 transform transition-transform group-open:rotate-180 group-hover:text-blue-500"
    ) do |s|
      s.path(
        d: "M6 9L12 15L18 9",
        stroke: "currentColor",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end
end
