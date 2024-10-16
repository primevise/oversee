class Oversee::Table::Row < Phlex::HTML
  def view_template(&)
    tr(class: "divide-x divide-gray-200") { yield }
  end

  def data(&)
    render Oversee::Table::Data.new(&)
  end
end
