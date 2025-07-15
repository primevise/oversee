# frozen_string_literal: true

class Oversee::Components::Table < Oversee::Components::Essence
  BASE = "min-w-full table-auto lg:table-fixed"
  CAPTION_CLASSES = "caption-bottom"
  THEAD_CLASSES = "border-b border-gray-950/5"
  TFOOT_CLASSES = "border-t border-gray-950/5"
  TH_CLASSES = "py-3 px-4 text-left text-[0.6rem] font-semibold uppercase text-gray-950/75 tabular-nums"
  TR_CLASSES = "last:border-b-0 border-b border-gray-950/5"
  TD_CLASSES = "py-2 px-4 text-left text-sm text-gray-950/70 tabular-nums whitespace-nowrap"

  attr_reader :unwrap

  def initialize(unwrap: false, **attributes)
    @unwrap = unwrap
    super(**attributes)
  end

  def around_template(&)
    unwrap ? yield : table(**attributes, &)
  end

  def view_template(&) = yield

  def thead(**mattributes, &)
    mattributes[:class] = merge_classes([ THEAD_CLASSES, mattributes[:class] ])
    super(**mattributes, &)
  end

  def tfoot(**mattributes, &)
    mattributes[:class] = merge_classes([ TFOOT_CLASSES, mattributes[:class] ])
    super(**mattributes, &)
  end

  def th(**mattributes, &)
    mattributes[:scope] = "col"
    mattributes[:class] = merge_classes([ TH_CLASSES, mattributes[:class] ])
    super(**mattributes, &)
  end

  def tr(**mattributes, &)
    mattributes[:scope] = "row"
    mattributes[:class] = merge_classes([ TR_CLASSES, mattributes[:class] ])
    super(**mattributes, &)
  end

  def td(**mattributes, &)
    mattributes[:class] = merge_classes([ TD_CLASSES, mattributes[:class] ])
    super(**mattributes, &)
  end

  def caption(**mattributes, &)
    mattributes[:class] = merge_classes([ CAPTION_CLASSES, mattributes[:class] ])
    super(**mattributes, &)
  end

  alias_method :head, :thead
  alias_method :body, :tbody
  alias_method :footer, :tfoot
  alias_method :column, :th
  alias_method :row, :tr
  alias_method :cell, :td

  private

  def initialize_merged_classes = merge_classes([ BASE, attributes[:class] ])
end
