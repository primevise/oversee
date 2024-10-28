class Oversee::Field::Value::BelongsTo < Phlex::HTML
  def initialize(key: nil, value: nil, **options)
    @key = key
    @value = value
    @options = options
  end

  def view_template
    p(title: @value, class:"inline-flex items-center gap-1") do
      if display_key?
        span { @key.humanize }
        span {"|"}
      end
      span { @value }
    end
  end

  private

  def display_key? = !!@options[:display_key]
end
