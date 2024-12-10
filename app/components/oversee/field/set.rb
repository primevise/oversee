# frozen_string_literal: true

class Oversee::Field::Set < Oversee::Field
  def view_template
    div(id: dom_id(resource, key), class:"flex flex-col gap-2") do
      div(class:"flex items-center justify-between h-10 gap-4") do
        render Oversee::Field::Label.new(key:, datatype:)
        button(type: :submit, class: "bg-black text-white text-xs font-medium px-6 py-2 hover:opacity-75 transition-opacity", form: field_form_id) { "Save" } if state == :input
      end
      div(class: "flex items-center justify-between gap-2") { send("#{state}_state") }
    end
  end

  def value_state
    render Oversee::Field::Display.new(resource:, key:, value:, datatype:, **@options)
    div(id: dom_id(@resource, :"#{key}_actions")) do
      button(
        class: "bg-gray-100 hover:bg-gray-200 text-gray-400 hover:text-blue-500 size-10 aspect-square inline-flex items-center justify-center transition-colors",
        data: { controller: "clipboard", action: "click->clipboard#copy", clipboard_content_value: value.to_s }
      ) do
        span(class: "hidden", data: { clipboard_target: "successIcon"}) { render Phlex::Icons::Iconoir::Check.new(class: "size-4 text-emerald-500", stroke_width: 1.75) }
        span(data: { clipboard_target: "copyIcon"}) { render Phlex::Icons::Iconoir::Copy.new(class: "size-4", stroke_width: 1.75) }
      end
    end
  end

  def input_state
    render Oversee::Field::Form.new(resource: @resource, datatype:, key:, value:)
  end

  private

  def state
    @state ||= @options[:state] || :value
  end
end
