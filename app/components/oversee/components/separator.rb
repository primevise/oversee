# frozen_string_literal: true

class Oversee::Components::Separator < Oversee::Components::Essence
  BASE = "border-gray-950/5"

  KINDS = {
    horizontal: "border-t",
    vertical: "border-l h-full"
  }

  attr_reader :kind, :attributes

  def initialize(kind: :horizontal, **attributes)
    @kind = kind
    super(**attributes)
  end

  def view_template
    tag((kind.to_sym == :horizontal ? :hr : :div), **attributes)
  end

  private

  def initialize_merged_classes = merge_classes([ BASE, KINDS[kind], @attributes[:class] ])
end
