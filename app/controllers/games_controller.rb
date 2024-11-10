class GamesController < ApplicationController
  def index
    render Views::Games::Index.new
  end
  def play
  end
end
