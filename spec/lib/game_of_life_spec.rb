require 'spec_helper'
require './lib/game_of_life'

describe GameOfLife do
  it 'starts a new game' do
    starting_array = [0, 0, 1, 1]

    game = GameOfLife.new(starting_array, 1, 1)

    expect(game.cells).to match_array [0, 0, 1, 1]
  end

  it 'kills cells with fewer than two live horizontal neighbors' do
    starting_array = [0, 0, 0, 1]
    game = GameOfLife.new(starting_array, 1, 1)

    game.advance

    expect(game.cells).to eq [0, 0, 0, 0]

    starting_array2 = [0, 0, 1, 1]
    game = GameOfLife.new(starting_array2, 1, 1)

    game.advance

    expect(game.cells).to eq [0, 0, 0, 0]
  end

  it 'does not kill cells with two live horizontal neighbors' do
    starting_array = [1, 1, 1]
    game = GameOfLife.new(starting_array, 1, 1)

    game.advance

    expect(game.cells).to eq [0, 1, 0]
  end

  it 'does not kill cells two live neighbors in any direction' do
    starting_array = [1, 1, 1, 1]
    game = GameOfLife.new(starting_array, 2, 2)

    game.advance

    expect(game.cells).to eq [1, 1, 1, 1]
  end

  it 'kills cells with more than three neighbors' do
    starting_array = [1, 1, 1, 1, 1, 1, 1, 1, 1]
    game = GameOfLife.new(starting_array, 3, 3)

    game.advance

    expected = [1, 1, 1, 1, 0, 1, 1, 1, 1]

    expect(game.cells).to eq expected
  end

  it 'creates a live cell in dead cells with three live neighbors' do
    starting_array = [1, 1, 1, 1, 0, 1]
    game = GameOfLife.new(starting_array, 3, 3)

    game.advance

    expected = [1, 1, 1, 0, 1, 0]

    expect(game.cells).to eq expected
  end
end