class Oversee::Table::Row < Phlex::HTML
  def view_template(&)
    tr(class: "divide-x divide-gray-200 hover:bg-gray-100/50 transition-colors duration-150 group") { yield }
  end

  def data(&)
    render Oversee::Table::Data.new(&)
  end
end
