class Oversee::Table::Body < Phlex::HTML
  def view_template(&)
    tbody(class: "divide-y divide-gray-200", &)
  end

  def row(&)
    render Oversee::Table::Row.new(&)
  end

  def data(&)
    render Oversee::Table::Data.new(&)
  end
end
