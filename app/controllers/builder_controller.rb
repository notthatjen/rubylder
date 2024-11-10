class BuilderController < ApplicationController
  def index
    render Views::Builder::Index.new params: params
  end
end
