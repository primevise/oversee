class Oversee::Table::Data < Phlex::HTML
  def view_template(&)
    td(class: "whitespace-nowrap py-2 px-3 text-sm text-gray-700", &)
  end
end
