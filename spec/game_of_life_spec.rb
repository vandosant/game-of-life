require 'spec_helper'
require_relative '../lib/game_of_life'

describe GameOfLife do
  it 'starts a new game' do
    game = GameOfLife.new(4, 2)

    game.generate_cells

    expect(game.cells).to match_array [0,0,1,1]
  end

  it 'randomizes the position of starting live cells' do
    game1 = GameOfLife.new(10, 4)
    game2 = GameOfLife.new(10, 4)

    game1.generate_cells
    game2.generate_cells

    expect(game1.cells).to match_array game2.cells
    expect(game1.cells).to_not eq game2.cells
  end
end