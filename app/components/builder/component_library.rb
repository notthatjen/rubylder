class Components::Builder::ComponentLibrary < Components::Base
  def view_template
    div(**attrs) do
      div(class: "p-4 border-b") do
        h2(class: "font-semibold") { "Component Library" }
      end

      div(class: "p-4 space-y-6") do
        section(class: "space-y-2") do
          h3(class: "text-sm font-medium") { "Basic Elements" }
          render_basic_elements
        end

        section(class: "space-y-2") do
          div(class: "flex items-center justify-between") do
            h3(class: "text-sm font-medium") { "Components" }
            render Default::Dialog.new do |dialog|
              dialog.trigger(
                class: "size-6 flex items-center justify-center rounded-md hover:bg-zinc-100"
              ) do
                svg(
                  class: "size-4",
                  xmlns: "http://www.w3.org/2000/svg",
                  viewbox: "0 0 24 24",
                  fill: "none",
                  stroke: "currentColor",
                  stroke_width: "2"
                ) do |s|
                  s.path(
                    stroke_linecap: "round",
                    stroke_linejoin: "round",
                    d: "M12 5v14m7-7H5"
                  )
                end
              end

              dialog.content(class: "w-[400px]") do
                dialog.title { "Create New Component" }

                form(
                  class: "mt-4 space-y-4",
                  data: { new_component_form: true }
                ) do
                  div(class: "space-y-2") do
                    label(class: "text-sm font-medium") { "Component Name" }
                    input(
                      type: "text",
                      class: "w-full px-3 py-2 border rounded-md",
                      placeholder: "MyComponent",
                      data: { new_component_name: true }
                    )
                  end

                  div(class: "flex justify-end gap-2 mt-6") do
                    button(
                      type: "button",
                      class: "px-4 py-2 text-sm border rounded-md hover:bg-zinc-50",
                      data: { dialog_close: true }
                    ) { "Cancel" }

                    button(
                      type: "submit",
                      class: "px-4 py-2 text-sm bg-zinc-900 text-white rounded-md hover:bg-zinc-800"
                    ) { "Create" }
                  end
                end
              end
            end
          end
          render_components
        end
      end
    end
  end

  private

  def render_basic_elements
    basic_elements.each do |element|
      render_draggable_item(element, "element")
    end
  end

  def render_components
    available_components.each do |component|
      render_draggable_item(component, "component")
    end
  end

  def render_draggable_item(item, type)
    div(
      class: "p-2 rounded hover:bg-zinc-50 cursor-move flex items-center gap-2",
      data: {
        draggable: true,
        type: type,
        name: item[:name].downcase,
        builder_item: true
      }
    ) do
      # Icon placeholder
      div(class: "size-4 rounded bg-zinc-200")
      span(class: "text-sm") { item[:name] }
    end
  end

  def basic_elements
    [
      { name: "Div", type: "element" },
      { name: "Button", type: "element" },
      { name: "Input", type: "element" },
      { name: "Text", type: "element" }
    ]
  end

  def available_components
    # Get all component files from the default directory
    component_files = Dir[Rails.root.join("app/components/default/*.rb")]

    # Transform file paths into component data
    component_files.map do |file|
      component_name = File.basename(file, ".rb").camelize
      { name: component_name, type: "component" }
    end.sort_by { |c| c[:name] }
  rescue => e
    Rails.logger.error("Failed to load components: #{e.message}")
    [] # Return empty array as fallback
  end
end
