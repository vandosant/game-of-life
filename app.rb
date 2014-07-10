require 'sinatra/base'
require_relative 'lib/game_of_life'
require_relative 'lib/grid_generator'

class App < Sinatra::Base
  set :game, GameOfLife.new(0, 0)
  set :grid, GridGenerator.map(settings.game.cells)
  set :grid_size_error_message, 'Grid size must be divisible by ten'
  set :live_cell_error_message, 'Live cells must be less than grid size'

  get '/' do
    erb :index, locals: {:game => settings.game, :grid => settings.grid}
  end

  post '/' do
    if grid_size_error?(params)
      erb :index, locals: {:game => settings.game, :grid => settings.grid, :error_message => settings.grid_size_error_message}
    elsif live_cells_error?(params)
      erb :index, locals: {:game => settings.game, :grid => settings.grid, :error_message => settings.live_cell_error_message}
    elsif params['advance']
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

  private

  def grid_size_error?(params)
    params['grid-size'].to_i % 10 != 0
  end

  def live_cells_error?(params)
    params['live-cells'].to_i > params['grid-size'].to_i
  end
end