require 'sinatra/base'
require_relative 'lib/game_of_life'

class App < Sinatra::Base
  set :game, GameOfLife.new(0,0)

  get '/' do
    erb :index, locals: {:game => settings.game}
  end

  post '/' do
    settings.game = GameOfLife.new(params['grid-size'].to_i, params['live-cells'].to_i)
    settings.game.generate_cells
    redirect '/'
  end
end