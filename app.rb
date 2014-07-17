require 'sinatra/base'
require_relative 'lib/game_of_life'
require_relative 'lib/grid_generator'

class App < Sinatra::Base
  set :game, GameOfLife.new([], 0, 0)
  set :grid, GridGenerator.map(settings.game.cells, 1, 1)

  get '/' do
    erb :index, locals: {:game => settings.game, :grid => settings.grid}
  end

  post '/' do
    starting_array = params[:board].split(",")
    rows = params[:rows].to_i
    columns = params[:columns].to_i
    settings.game = GameOfLife.new(starting_array, rows, columns)
    settings.grid = GridGenerator.map(settings.game.cells, rows, columns)
    redirect '/new'
  end

  get '/new' do
    erb :new, locals: {:game => settings.game, :grid => settings.grid}
  end

  post '/new' do
    settings.game.advance
    settings.grid = GridGenerator.map(settings.game.cells, settings.game.rows, settings.game.columns)
    redirect '/new'
  end
end