class Oversee::Table::Head < Phlex::HTML
  def view_template(&)
    thead(class: "bg-gray-50/75", &)
  end

  def row(&)
    render Oversee::Table::Row.new(&)
  end
end
