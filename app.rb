require 'sinatra/base'
require_relative 'lib/game_of_life'
require_relative 'lib/grid_generator'

class App < Sinatra::Base
  set :game, GameOfLife.new(0, 0)
  set :grid, GridGenerator.map(settings.game.cells)

  get '/' do
    erb :index, locals: {:game => settings.game, :grid => settings.grid}
  end

  post '/' do
    if params['advance']
      settings.game.advance
      settings.grid = GridGenerator.map(settings.game.cells)
      redirect '/'
    else
      settings.game = GameOfLife.new(params['grid-size'].to_i, params['live-cells'].to_i)
      settings.game.generate_cells
      settings.grid = GridGenerator.map(settings.game.cells)
      redirect '/'
    end
  end
end