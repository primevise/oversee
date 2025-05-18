class Oversee::Components::Field::Input::Boolean < Oversee::Components::Field::Input
  def view_template
    div(data: { controller: :switch }) do
      input(type: :hidden, id: field_id, name: field_name, value: value.to_s , data: { switch_target: :input })
      comment { %(Enabled: "bg-emerald-500", Not Enabled: "bg-gray-200") }
      button(
        type: :button,
        role: :switch,
        aria_checked: false,
        data: { action: "switch#toggle", switch_target: :button },
        class:
          "relative inline-flex h-6 w-11 shrink-0 cursor-pointer rounded-full border-2 border-transparent bg-gray-200 transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-gray-100 focus:ring-offset-2",
      ) do
        span(class: "sr-only") { "Use setting" }
        comment { %(Enabled: "translate-x-5", Not Enabled: "translate-x-0") }
        span(
          aria_hidden: "true",
          data: { switch_target: :lever },
          class:
            "pointer-events-none inline-block size-5 translate-x-0 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out"
        )
      end
    end
  end
end
