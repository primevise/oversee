class Oversee::Views::Resources::New < Oversee::Views::Base
  def initialize(resource:)
    @resource = resource
    @record = @resource.record
  end

  def view_template
    render Oversee::Components::Dashboard::Header.new do |header|
      header.item do
        render Phlex::Icons::Iconoir::Folder.new(class: "size-4.5 text-gray-400", stroke_width: 1.75)
        header.title { "New #{@resource.to_s}"}
      end
    end


    div(class: "p-4") do
      render Oversee::Components::Resource::Form.new(record: @record)
    end
  end
end
