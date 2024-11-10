class ComponentsController < ApplicationController
  def create
    ComponentManager.create_component(
      name: params[:name],
      properties: params[:properties]
    )

    head :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
