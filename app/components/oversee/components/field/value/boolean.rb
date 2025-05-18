class Oversee::Components::Field::Value::Boolean < Oversee::Components::Field::Value
  def view_template
    render value ? Phlex::Icons::Iconoir::Check.new(class: "size-4 text-emerald-500") : Phlex::Icons::Iconoir::Xmark.new(class: "size-4 text-rose-500")
  end
end
