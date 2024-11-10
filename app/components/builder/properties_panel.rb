class Components::Builder::PropertiesPanel < Components::Base
  props component_name: nil

  def view_template
    div(**attrs) do
      div(class: "p-4 border-b") do
        h2(class: "font-semibold") { props.component_name || "Properties" }
      end

      div(class: "p-4 space-y-4", data: { properties_panel: true }) do
        if props.component_name
          render_component_properties
        else
          render_empty_state
        end
      end
    end
  end

  private

  def render_component_properties
    component_class = "Components::Default::#{props.component_name}".constantize
    properties = component_class.props_config

    properties.each do |name, config|
      div(class: "space-y-2") do
        label(class: "text-sm font-medium") { name.to_s.humanize }
        input(
          type: "text",
          class: "w-full px-3 py-2 border rounded-md",
          value: config[:default].to_s,
          data: { property_name: name }
        )
      end
    end
  rescue NameError => e
    Rails.logger.error("Failed to load component properties: #{e.message}")
    div(class: "text-red-500") { "Component not found" }
  end

  def render_empty_state
    div(class: "text-zinc-500 text-sm text-center") do
      "Select a component to edit its properties"
    end
  end
end
