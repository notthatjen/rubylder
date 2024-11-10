class ComponentManager
  def self.create_component(name:, properties: {})
    # Validate component name
    normalized_name = name.to_s.camelize

    # Generate the component
    ComponentGenerator.generate(
      name: normalized_name,
      type: "default",
      properties: properties
    )

    # Add to available components list
    update_component_library(normalized_name)
  end

  def self.use_component(name, **attrs)
    component_class = "Components::Default::#{name}".constantize
    component_class.new(**attrs)
  end

  private

  def self.update_component_library(component_name)
    library_file = Rails.root.join("app/components/builder/component_library.rb")
    content = File.read(library_file)

    # Find the available_components method
    if content =~ /def available_components\s*\[([^\]]*)\]/m
      components_list = $1
      updated_list = components_list + %Q(\n      { name: "#{component_name}", type: "default" },)

      # Update the file
      new_content = content.sub(/def available_components\s*\[([^\]]*)\]/m,
                              "def available_components\n    [#{updated_list}")

      File.write(library_file, new_content)
    end
  end
end
