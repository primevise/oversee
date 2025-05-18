class Oversee::Components::Table::Body < Phlex::HTML
  def view_template(&)
    tbody(class: "divide-y divide-gray-200", &)
  end

  def row(&)
    render Oversee::Components::Table::Row.new(&)
  end

  def data(&)
    render Oversee::Components::Table::Data.new(&)
  end
end
