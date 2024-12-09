class Oversee::Field::Value::Boolean < Oversee::Field::Value
  def view_template
    render value ? Phlex::Icons::Iconoir::Check.new(class: "size-4 text-emerald-500") : Phlex::Icons::Iconoir::Xmark.new(class: "size-4 text-rose-500")
  end
end
