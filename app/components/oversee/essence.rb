class Oversee::Essence < Phlex::HTML
  TAILWIND_MERGER = ::TailwindMerge::Merger.new.freeze unless defined?(TAILWIND_MERGER)

  attr_accessor :attributes

  def initialize(**attributes)
    @attributes = merge_attributes(**attributes)
  end

  private

  def default_attributes = {}
  def merge_classes(*classes) = TAILWIND_MERGER.merge([ *classes ].compact)

  def merge_attributes(**attributes)
    default_attributes.deep_merge(attributes)
  end
end
