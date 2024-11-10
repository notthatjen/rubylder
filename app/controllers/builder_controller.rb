class BuilderController < ApplicationController
  def index
    render Views::Builder::Index.new params: params
  end

  def edit
    render Views::Builder::Edit.new params: params
  end

  def generate_component
    result = ::Builder::ComponentGenerator.generate(
      name: component_params[:name],
      type: component_params[:type],
      properties: component_params[:properties]
    )

    if result
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def update_component
    ComponentUpdater.update(
      name: params[:name],
      type: params[:type],
      content: params[:content]
    )

    head :ok
  end

  private

  def component_params
    params.require(:component).permit(:name, :type, properties: {})
  end
end
