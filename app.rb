require 'sinatra/base'
require_relative 'lib/game_of_life'
require_relative 'lib/grid_generator'

class App < Sinatra::Base
  set :game, GameOfLife.new(0, 0)
  set :grid, GridGenerator.map(settings.game.cells)
  set :error_message, nil

  get '/' do
    if errors?
      settings.error_message = nil
    end
    erb :index, locals: {:game => settings.game, :grid => settings.grid}
  end

  post '/' do
    if grid_size_error?(params)
      settings.error_message = 'Grid size must be divisible by ten'
      erb :index, locals: {:game => settings.game, :grid => settings.grid, :error_message => settings.error_message}
    elsif live_cells_error?(params)
      settings.error_message = 'Live cells must be less than grid size'
      erb :index, locals: {:game => settings.game, :grid => settings.grid, :error_message => settings.error_message}
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

  def errors?
    settings.error_message != nil
  end

  def grid_size_error?(params)
    params['grid-size'].to_i % 10 != 0
  end

  def live_cells_error?(params)
    params['live-cells'].to_i > params['grid-size'].to_i
  end
end