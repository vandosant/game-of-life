require 'sinatra/base'
require_relative 'lib/game_of_life'

class App < Sinatra::Base
  set :game, GameOfLife.new([], 0, 0)

  get '/' do
    erb :index
  end

  post '/' do
    starting_array = params[:board].split(",").map { |cell| cell.to_i }
    rows = params[:rows].to_i
    columns = params[:columns].to_i
    settings.game = GameOfLife.new(starting_array, rows, columns)
    redirect '/new'
  end

  get '/new' do
    erb :new, locals: {:game => settings.game}
  end

  post '/new' do
    settings.game.advance
    redirect '/new'
  end
end