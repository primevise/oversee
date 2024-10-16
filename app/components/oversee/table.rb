class Oversee::Table < Phlex::HTML
  def view_template(&)
    div(class: "overflow-x-hidden") do
      div(class: "-mx-4 overflow-x-auto sm:-mx-6 lg:-mx-8") do
        div(class: "inline-block min-w-full align-middle sm:px-6 lg:px-8") do
          table(class: "min-w-full divide-y divide-gray-200") do
            yield
          end
        end
      end
    end
  end

  def head(&)
    render Oversee::Table::Head.new(&)
  end

  def body(&)
    render Oversee::Table::Body.new(&)
  end
end
