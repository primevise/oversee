class Oversee::Components::Essence < Phlex::HTML
  TAILWIND_MERGER = ::TailwindMerge::Merger.new.freeze unless defined?(TAILWIND_MERGER)

  attr_reader :attributes

  def initialize(**attributes)
    @attributes = mix(initialize_default_attributes, attributes)
    @attributes[:class] = initialize_merged_classes
  end

  private

  def merge_classes(*classes) = TAILWIND_MERGER.merge([ *classes ].compact)
  def initialize_merged_classes = ""
  def initialize_default_attributes = {}
end
