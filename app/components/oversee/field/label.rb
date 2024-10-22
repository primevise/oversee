class Oversee::Field::Label < Oversee::Base
  ICON_MAP = {
    string: Phlex::Icons::Iconoir::Text,
    text: Phlex::Icons::Iconoir::TextSquare,
    integer: Phlex::Icons::Iconoir::Number0Square,
    datetime: Phlex::Icons::Iconoir::Calendar,
    boolean: Phlex::Icons::Iconoir::SwitchOn,
    data: Phlex::Icons::Iconoir::Page,
  }

  def initialize(datatype: :string, key: nil)
    @datatype = datatype
    @key = key
  end

  def view_template
    div(id: "#{@key}_label", class:"inline-flex items-center space-x-2") do
      div(class: "size-5 bg-gray-100 inline-flex items-center justify-center") do
        render ICON_MAP[@datatype] ? ICON_MAP[@datatype].new(class: "size-3") : ICON_MAP[:data].new(class: "size-3")
      end
      label(class: "uppercase text-xs text-gray-700 font-medium block cursor-auto") { @key.to_s.humanize(keep_id_suffix: true) }
    end
  end
end
