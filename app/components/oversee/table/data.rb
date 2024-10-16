class Oversee::Table::Data < Phlex::HTML
  def view_template(&)
    td(class: "whitespace-nowrap p-4 text-sm text-gray-500", &)
  end
end
