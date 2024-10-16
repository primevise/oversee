class Oversee::Table::Head < Phlex::HTML
  def view_template(&)
    thead(class: "bg-white", &)
  end

  def row(&)
    render Oversee::Table::Row.new(&)
  end
end
