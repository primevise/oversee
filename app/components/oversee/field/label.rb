class Oversee::Field::Label < Oversee::Base
  def initialize(datatype: :string, key: nil)
    @datatype = datatype
    @key = key
  end

  def view_template
    div(class:"inline-flex items-center space-x-2") do
      div(class: "size-5 bg-gray-100 inline-flex items-center justify-center") do
        respond_to?("#{@datatype}_icon", true) ? send("#{@datatype}_icon") : data_icon
      end
      label(class: "uppercase text-xs text-gray-500 font-medium block") { @key.to_s.humanize }
    end
  end

  private

  def string_icon
    svg(
      stroke_width: "2",
      viewbox: "0 0 24 24",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      color: "currentColor",
      class: "size-2.5"
    ) do |s|
      s.path(
        d: "M19 7V5L5 5V7",
        stroke: "currentColor",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
      s.path(
        d: "M12 5L12 19M12 19H10M12 19H14",
        stroke: "currentColor",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end

  def integer_icon
    svg(
      xmlns: "http://www.w3.org/2000/svg",
      class: "h-2.5 w-2.5",
      viewbox: "0 0 24 24",
      stroke_width: "2",
      stroke: "currentColor",
      fill: "none",
      stroke_linecap: "round",
      stroke_linejoin: "round"
    ) do |s|
      s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
      s.path(d: "M4 17v-10l7 10v-10")
      s.path(d: "M15 17h5")
      s.path(d: "M17.5 10m-2.5 0a2.5 3 0 1 0 5 0a2.5 3 0 1 0 -5 0")
    end
  end

  def text_icon
    svg(
      stroke_width: "2",
      viewbox: "0 0 24 24",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      color: "currentColor",
      class: "size-2.5"
    ) do |s|
      s.path(
        d: "M19 7V5L5 5V7",
        stroke: "currentColor",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
      s.path(
        d: "M12 5L12 19M12 19H10M12 19H14",
        stroke: "currentColor",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end

  def boolean_icon
    svg(
      xmlns: "http://www.w3.org/2000/svg",
      class: "h-2.5 w-2.5",
      viewbox: "0 0 24 24",
      stroke_width: "2",
      stroke: "currentColor",
      fill: "none",
      stroke_linecap: "round",
      stroke_linejoin: "round"
    ) do |s|
      s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
      s.path(d: "M8 12m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0")
      s.path(
        d:
          "M2 6m0 6a6 6 0 0 1 6 -6h8a6 6 0 0 1 6 6v0a6 6 0 0 1 -6 6h-8a6 6 0 0 1 -6 -6z"
      )
    end
  end

  def enum_icon
    svg(
      xmlns: "http://www.w3.org/2000/svg",
      class: "h-2.5 w-2.5",
      viewbox: "0 0 24 24",
      stroke_width: "2",
      stroke: "currentColor",
      fill: "none",
      stroke_linecap: "round",
      stroke_linejoin: "round"
    ) do |s|
      s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
      s.path(
        d:
          "M3 3m0 2a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v14a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2z"
      )
      s.path(d: "M9 11l3 3l3 -3")
    end
  end

  def datetime_icon
    svg(
      xmlns: "http://www.w3.org/2000/svg",
      class: "h-2.5 w-2.5",
      viewbox: "0 0 24 24",
      stroke_width: "2",
      stroke: "currentColor",
      fill: "none",
      stroke_linecap: "round",
      stroke_linejoin: "round"
    ) do |s|
      s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
      s.path(
        d:
          "M4 7a2 2 0 0 1 2 -2h12a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-12a2 2 0 0 1 -2 -2v-12z"
      )
      s.path(d: "M16 3v4")
      s.path(d: "M8 3v4")
      s.path(d: "M4 11h16")
      s.path(d: "M11 15h1")
      s.path(d: "M12 15v3")
    end
  end

  def data_icon
    svg(
      xmlns: "http://www.w3.org/2000/svg",
      viewbox: "0 0 24 24",
      fill: "none",
      stroke: "currentColor",
      stroke_width: "2",
      stroke_linecap: "round",
      stroke_linejoin: "round",
      class: "h-2.5 w-2.5",
    ) do |s|
      s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
      s.path(d: "M15 12h.01")
      s.path(d: "M12 12h.01")
      s.path(d: "M9 12h.01")
      s.path(d: "M6 19a2 2 0 0 1 -2 -2v-4l-1 -1l1 -1v-4a2 2 0 0 1 2 -2")
      s.path(d: "M18 19a2 2 0 0 0 2 -2v-4l1 -1l-1 -1v-4a2 2 0 0 0 -2 -2")
    end
  end
end
