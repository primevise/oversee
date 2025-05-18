class Oversee::Components::Table::Head < Phlex::HTML
  def view_template(&)
    thead(class: "bg-gray-50/75", &)
  end

  def row(&)
    render Oversee::Components::Table::Row.new(&)
  end
end
