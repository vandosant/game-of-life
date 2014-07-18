require 'spec_helper'
require './lib/game_of_life'

describe GameOfLife do


  it 'starts a new game (square)' do
    starting_array = [0, 1, 1, 0]

    game = GameOfLife.new(starting_array, 2, 2)

    expect(game.cells).to match_array [0, 1, 1, 0]
    expect(game.rows).to eq 2
    expect(game.columns).to eq 2

    expect(game.current_matrix).to eq [[0, 1], [1, 0]]
  end

  it 'starts a new game (rectangle)' do
    starting_array = [0, 1, 0, 0, 1, 0]

    game = GameOfLife.new(starting_array, 2, 3)

    expect(game.cells).to match_array [0, 1, 0, 0, 1, 0]
    expect(game.rows).to eq 2
    expect(game.columns).to eq 3

    expect(game.current_matrix).to eq [[0, 1, 0], [0, 1, 0]]
  end

  it 'knows the number of live neighbors for a cell' do
    starting_array = [0, 1, 0, 0]

    game = GameOfLife.new(starting_array, 2, 2)

    expect(game.live_neighbors(0, 0)).to eq 1
    expect(game.live_neighbors(0, 1)).to eq 0
    expect(game.live_neighbors(1, 0)).to eq 1
    expect(game.live_neighbors(1, 1)).to eq 1
  end

  it 'kills cells with less than two neighbors' do
    starting_array = [1, 0, 0, 0]

    game = GameOfLife.new(starting_array, 2, 2)

    expect(game.current_matrix[0][0]).to eq 1

    game.advance

    expect(game.current_matrix[0][0]).to eq 0
    expect(game.current_matrix).to eq [[0, 0], [0, 0]]
  end

  it 'does not kill cells with two live neighbors' do
    starting_array = [1, 1, 1, 0]

    game = GameOfLife.new(starting_array, 2, 2)

    expect(game.current_matrix[0][0]).to eq 1

    game.advance

    expect(game.current_matrix[0][0]).to eq 1
  end

  it 'does not kill cells with three live neighbors' do
    starting_array = [1, 1, 1, 1]

    game = GameOfLife.new(starting_array, 2, 2)

    expect(game.current_matrix).to eq [[1, 1], [1, 1]]

    game.advance

    expect(game.current_matrix).to eq [[1, 1], [1, 1]]
  end

  it 'kills cells with four live neighbors' do
    starting_array = [1, 1, 0, 1, 1, 0, 1, 0, 0]

    game = GameOfLife.new(starting_array, 3, 3)

    expect(game.current_matrix[1][0]).to eq 1
    expect(game.current_matrix).to eq [[1, 1, 0], [1, 1, 0], [1, 0, 0]]

    game.advance

    expect(game.current_matrix[1][0]).to eq 0
  end

  it 'creates a live cell in dead cells with three live neighbors' do
    starting_array = [0, 1, 1, 1]

    game = GameOfLife.new(starting_array, 2, 2)

    expect(game.current_matrix[0][0]).to eq 0
    expect(game.current_matrix).to eq [[0, 1], [1, 1]]

    game.advance

    expect(game.current_matrix[0][0]).to eq 1
  end

  it 'prints the current cell matrix' do
    starting_array = [0, 1, 0, 0]

    game = GameOfLife.new(starting_array, 2, 2)

    expect(game.to_s).to eq "0 1\n0 0"
  end
end