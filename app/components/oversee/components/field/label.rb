class Oversee::Components::Field::Label < Oversee::Components::Field
  ICON_MAP = {
    belongs_to: Phlex::Icons::Iconoir::Database,
    boolean: Phlex::Icons::Iconoir::SwitchOn,
    data: Phlex::Icons::Iconoir::Page,
    date: Phlex::Icons::Iconoir::Calendar,
    datetime: Phlex::Icons::Iconoir::Calendar,
    has_many: Phlex::Icons::Iconoir::Database,
    integer: Phlex::Icons::Iconoir::Number0Square,
    json: Phlex::Icons::Iconoir::CodeBracketsSquare,
    jsonb: Phlex::Icons::Iconoir::CodeBracketsSquare,
    rich_text: Phlex::Icons::Iconoir::TextSquare,
    string: Phlex::Icons::Iconoir::Text,
    text: Phlex::Icons::Iconoir::TextSquare,
  }

  def view_template
    div(id: "#{key}_label", class:"inline-flex items-center space-x-2") do
      div(class: "size-5 bg-gray-100 inline-flex items-center justify-center") { render icon.new(class: "size-3") }
      label(class: "uppercase text-[0.65rem] text-gray-700 font-medium block cursor-auto", for: key) { key.to_s.humanize(keep_id_suffix: true) }
      a(href:, class: "hover:text-blue-500 transition-colors") { render Phlex::Icons::Iconoir::ArrowUpRight.new(class: "size-3") } if has_link?
    end
  end

  def icon
    ICON_MAP[datatype&.to_sym] || ICON_MAP[:data]
  end

  def href
    @href ||= @options[:href]
  end

  def has_link?
    @has_link ||= !!href
  end
end
