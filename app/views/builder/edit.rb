class Views::Builder::Edit < Views::Base
  def view_template
    div(class: "h-screen w-screen flex") do
      # Left Sidebar - Component Library
      render Builder::ComponentLibrary.new(class: "w-64 border-r bg-white")

      # Main Content Area
      div(class: "flex-1 flex flex-col") do
        # Top Bar
        render Builder::Topbar.new

        # Main Canvas
        main(class: "flex-1 bg-zinc-50 p-4") do
          div(class: "bg-white rounded-lg shadow h-full", data: { builder_canvas: true }) do
            render_example_component if editing_component?
          end
        end
      end

      # Right Sidebar - Properties Panel
      render Builder::PropertiesPanel.new(
        class: "w-80 border-l bg-white",
        component_name: params[:component]
      )
    end
  end

  private

  def editing_component?
    params[:component].present?
  end

  def render_example_component
    component_class = "Components::Example::#{params[:component].titleize}".constantize
    render component_class.new
  rescue NameError => e
    Rails.logger.error("Failed to load example component: #{e.message}")
    div(class: "p-4 text-red-500") { "Component not found" }
  end
end
