class Oversee::Components::Field::Value::Boolean < Oversee::Components::Field::Value
  def view_template
    if value
      render Phlex::Icons::Iconoir::Check.new(class: "size-5 p-0.5 bg-emerald-500/7 text-emerald-500 rounded-xs")
    else
      render Phlex::Icons::Iconoir::Xmark.new(class: "size-5 p-0.5 bg-rose-500/5 size-4 text-rose-500 rounded-xs")
    end
  end
end
