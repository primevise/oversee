# frozen_string_literal: true

class Oversee::Resources::New < Oversee::Base
  def initialize(record:, resource:, params:)
    @record = Oversee::Record.new(record:)
    @resource = resource
  end

  def around_template
    render Oversee::Layout::Application.new { super }
  end

  def view_template
    render Oversee::Dashboard::Header.new do |header|
      header.item do
        render Phlex::Icons::Iconoir::Folder.new(class: "size-4.5 text-gray-400", stroke_width: 1.75)
        header.title { "New #{@resource.to_s}"}
      end
    end


    div(class: "p-4") do
      render Oversee::Resources::Form.new(record: @record)
    end
  end
end
