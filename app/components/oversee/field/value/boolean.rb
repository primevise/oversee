class Oversee::Field::Value::Boolean < Phlex::HTML
  def initialize(key: nil, value: nil, kind: :value)
    @value = value
  end

  def view_template
    @value ? check_icon : x_icon
  end

  private

  def check_icon
    svg(
      stroke_width: "2",
      viewbox: "0 0 24 24",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      color: "currentColor",
      class: "size-4 text-emerald-500"
    ) do |s|
      s.path(
        d: "M5 13L9 17L19 7",
        stroke: "currentColor",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end

  def x_icon
    svg(
      stroke_width: "1.5",
      viewbox: "0 0 24 24",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      color: "currentColor",
      class: "size-4 text-rose-500"
    ) do |s|
      s.path(
        d:
          "M6.75827 17.2426L12.0009 12M17.2435 6.75736L12.0009 12M12.0009 12L6.75827 6.75736M12.0009 12L17.2435 17.2426",
        stroke: "currentColor",
        stroke_width: "1.5",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end
end
