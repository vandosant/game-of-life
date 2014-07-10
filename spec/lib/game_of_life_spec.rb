require 'spec_helper'
require './lib/game_of_life'

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

  it 'kills cells with fewer than two live horizontal neighbors' do
    game = GameOfLife.new(4, 1)

    game.generate_cells

    game.advance

    expect(game.cells).to eq [0,0,0,0]

    game = GameOfLife.new(4, 2)

    game.generate_cells

    game.advance

    expect(game.cells).to eq [0,0,0,0]
  end

  it 'does not kill cells with two live horizontal neighbors' do
    game = GameOfLife.new(4, 4)

    game.generate_cells

    game.advance

    expect(game.cells).to match_array [0,0,1,1]
  end

  it 'does not kill cells two live neighbors in any direction' do
    # row height defaults to 10 cells
    game = GameOfLife.new(20, 20)

    game.generate_cells

    game.advance

    expect(game.cells).to eq [1]*20
  end

  it 'kills cells with more than three neighbors' do
    game = GameOfLife.new(30, 30)

    game.generate_cells

    game.advance

    expected = ([1]*22) + ([0]*8)

    expect(game.cells).to match_array expected
  end

  it 'creates a live cell in dead cells with three live neighbors' do
    game = GameOfLife.new(30, 30)

    game.generate_cells

    game.advance

    expected = ([1]*22) + ([0]*8)

    expect(game.cells).to match_array expected

    game.advance

    expected = ([1]*24) + ([0]*6)

    expect(game.cells).to match_array expected
  end
end